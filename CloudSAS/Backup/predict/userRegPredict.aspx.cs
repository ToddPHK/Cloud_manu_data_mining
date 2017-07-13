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

    public partial class userRegPredict : System.Web.UI.Page
{
        public string sjson;
        private Double ConvertOriginToDouble(DataRow dr)
        {
            return Convert.ToDouble(dr[1]);
        }

    protected void Page_Load(object sender, EventArgs e)
    {
        //string sql = "SELECT YEAR(RegisterTime) as year, COUNT(*) as origin FROM UserInfor where UserState='1' GROUP BY YEAR(RegisterTime) ORDER BY year ASC";
        string sql = "SELECT datename(YYYY, RegisterTime)+ '-' + DATENAME(MM, RegisterTime) AS MyDate, COUNT(*) as origin FROM UserInfor where UserState='1' GROUP BY DATENAME(YYYY, RegisterTime), DATENAME(MM, RegisterTime),DATEPART(YYYY, RegisterTime),DATEPART(MM, RegisterTime) ORDER BY DATEPART(YYYY, RegisterTime),DATEPART(MM, RegisterTime)";
        //DataTable TempDataTable = new DataTable();
        DataTable TempDataTable = DbHelperSQL.FindTable(2, sql);
        //TempDataTable.Columns.Add("Name");
        //TempDataTable.Columns.Add("Age");
        //TempDataTable.Columns.Add("Address");


            ///////// JSON String with Rows And Cols////////////////////////////
            //JSON_DataTable_DataHolder.Value= Object_JSON_Class.JSON_DataTable(TempDataTable);
            ///////// JSON String with Rows And ColNames////////////////////////////
            //JSON_Parameter_DataHolder.Value= Object_JSON_Class.CreateJsonParameters(TempDataTable);
        DataRow[] myrow = new DataRow[TempDataTable.Rows.Count];
        TempDataTable.Rows.CopyTo(myrow, 0);
        //double[] myValue = { 3, 4, 5, 6, 7, 9, 11, 13, 15, 17, 22, 27, 29 };
        //double[] myValue = { 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 17, 19};
        //double[] myValue = { 3, 1, 2, 1, 1, 1, 1, 3, 3, 4, 32};//GMģ�Ͳ�����������ͻ�������
                double[] myValue = Array.ConvertAll(myrow, new Converter<DataRow, double>(ConvertOriginToDouble));
        /*   
        Response.Write("��ʷֵ�� ");
                foreach (var item in myValue)
                {
                    Response.Write(item.ToString() + " ");
                }
          */
            int num = 5;//��Ԥ�����ݸ���
            ES es1 = new ES(myValue, num, 0.8);
            //double[] result = es1.ES_FirResult();
            double[] result = es1.ES_SecResult();
            //double[] result = gm1.Result_revised();
            /*
            Response.Write("Ԥ��ֵ�� ");
            foreach (var item in result)
            {
                Response.Write(item.ToString() + " ");
            } 
            */ 
            /////////////////////////////////////////////////////////////////////
            DataColumn dc = new DataColumn("predict", typeof(string));

            TempDataTable.Columns.Add(dc);
            int length = myValue.GetLength(0);
            int i;
            for ( i = 0; i < (length + num); i++)
            {
                if (i >= length)
                {
                    DataRow dr = TempDataTable.NewRow();
                    dr[0] =JSON_Class.YearMonthAdd(TempDataTable.Rows[i-1][0].ToString(),1);
                    dr[2] = Math.Round(result[i],0).ToString();//��Ԥ��ֵ��������Ϊ����
                    TempDataTable.Rows.Add(dr);
                }else{
                    DataRow dr = TempDataTable.Rows[i];
                    dr[0] = JSON_Class.YearMonthAdd(dr[0].ToString(), -1);
                    dr[2] = Math.Round(result[i],0).ToString();

                }
            }
            JSON_Class Object_JSON_Class = new JSON_Class();
            string[] c = {"date","origin","predict" };
            sjson = Object_JSON_Class.JSON_DT_YearMonth(TempDataTable, c);//

            //chartdiv.Style["width"] = "870px";

    }
 }
}
