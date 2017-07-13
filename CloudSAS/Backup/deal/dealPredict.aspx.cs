using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DBUtility;
using Model;
using Ext.Net;

namespace CloudSAS{

    public partial class dealPredict : System.Web.UI.Page
{
        public string sjson;

        private Double ConvertOriginToDouble(DataRow dr)
        {
            return Convert.ToDouble(dr[1]);
        }

        private Double ConvertPriceToDouble(DataRow dr)
        {
            return Convert.ToDouble(dr[2]);
        }

    protected void Page_Load(object sender, EventArgs e)
    {
        //string sql = "SELECT YEAR(DealDate) as year, COUNT(*) as count,Sum(price) as price FROM deal_fact WHERE deal='1' GROUP BY YEAR(DealDate) ORDER BY year ASC";
        //string sql = "SELECT  CAST(YEAR(DealDate) AS VARCHAR(4))+ '-' + CAST(MONTH(DealDate) AS VARCHAR(2)) AS MyDate, COUNT(*) as count,Sum(price) as price FROM deal_fact WHERE deal='1' GROUP BY   CAST(YEAR(DealDate) AS VARCHAR(4))+ '-' + CAST(MONTH(DealDate) AS VARCHAR(2)) ORDER BY MyDate ASC";
        string sql = "SELECT datename(YYYY, DealDate)+ '-' + DATENAME(MM, DealDate) AS MyDate, COUNT(*) as count,Sum(price) as price FROM deal_fact WHERE deal='1' GROUP BY  DATENAME(YYYY, DealDate), DATENAME(MM, DealDate),DATEPART(YYYY, DealDate),DATEPART(MM, DealDate) ORDER BY DATEPART(YYYY, DealDate),DATEPART(MM, DealDate)";
        //DataTable TempDataTable = new DataTable();
        DataTable TempDataTable = DbHelperSQL.FindTable(3, sql);
        //TempDataTable.Columns.Add("Name");
        //TempDataTable.Columns.Add("Age");
        //TempDataTable.Columns.Add("Address");


            ///////// JSON String with Rows And Cols////////////////////////////
            //JSON_DataTable_DataHolder.Value= Object_JSON_Class.JSON_DataTable(TempDataTable);
            ///////// JSON String with Rows And ColNames////////////////////////////
            //JSON_Parameter_DataHolder.Value= Object_JSON_Class.CreateJsonParameters(TempDataTable);
            DataRow[] myrow = new DataRow[TempDataTable.Rows.Count];
            TempDataTable.Rows.CopyTo(myrow, 0);
            double[] myValue = Array.ConvertAll(myrow, new Converter<DataRow, double>(ConvertOriginToDouble));
            double[] myValue2 = Array.ConvertAll(myrow, new Converter<DataRow, double>(ConvertPriceToDouble));
            //double[] xValue ={2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018};
            int length = myValue.GetLength(0); 
            int num = 5;//待预测数据个数           

            double[] xValue = new double[length + num];
            //int s=Int32.Parse(TempDataTable.Rows[0][0].ToString());
            for (int i = 0; i < (length + num ); i++) xValue[i] = Convert.ToDouble(i);
            //for (int i = 1; i <= (length + num); i++) xValue[i] = Convert.ToDouble(i);
            /*
            Response.Write("历史值： ");
            foreach (var item in xValue)
                {
                    Response.Write(item.ToString() + " ");
                }
            */

            //GM gm1 = new GM(myValue, num);
            //double[] result = gm1.Result();
            LinearRegression lr1 = new LinearRegression(myValue,xValue,num);
            LinearRegression lr2 = new LinearRegression(myValue2, xValue, num);
            double[] result = lr1.FirResult();
            double[] result2 = lr2.FirResult();
            DataColumn dc = new DataColumn("predict", typeof(string));
            DataColumn dc2 = new DataColumn("predict2", typeof(string));
            TempDataTable.Columns.Add(dc); TempDataTable.Columns.Add(dc2);
            //int i;
            for (int i = 0; i < (length + num); i++)
            {
                if (i >= length)
                {
                    DataRow dr = TempDataTable.NewRow();
                    dr[0] = JSON_Class.YearMonthAdd(TempDataTable.Rows[i-1][0].ToString(),1);
                    dr[3] = Math.Round(result[i],0).ToString();//将预测值四舍五入为整数
                    dr[4] = Math.Round(result2[i], 0).ToString();
                    TempDataTable.Rows.Add(dr);
                }else{
                    DataRow dr = TempDataTable.Rows[i];
                    dr[0] = JSON_Class.YearMonthAdd(dr[0].ToString(),-1);
                    dr[3] = Math.Round(result[i],0).ToString();
                    dr[4] = Math.Round(result2[i], 0).ToString();

                }
            }
            JSON_Class Object_JSON_Class = new JSON_Class();
            //string[] c = { "year", "origin", "price", "predict", "predict2" };
            string[] c = { "date", "origin", "price", "predict", "predict2" };
            sjson = Object_JSON_Class.JSON_DT_YearMonth(TempDataTable, c);//

            //chartdiv.Style["width"] = "870px";

    }
 }
}
