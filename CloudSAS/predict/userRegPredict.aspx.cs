using System;
using System.Data;
using DBUtility;
using Model;

namespace CloudSAS
{

    public partial class userRegPredict : System.Web.UI.Page
{
        public string sjson;
        private Double ConvertOriginToDouble(DataRow dr)
        {
            return Convert.ToDouble(dr[1]);
        }

    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "SELECT datename(YYYY, RegisterTime)+ '-' + DATENAME(MM, RegisterTime) AS MyDate, COUNT(*) as origin FROM UserInfor where UserState='1' GROUP BY DATENAME(YYYY, RegisterTime), DATENAME(MM, RegisterTime),DATEPART(YYYY, RegisterTime),DATEPART(MM, RegisterTime) ORDER BY DATEPART(YYYY, RegisterTime),DATEPART(MM, RegisterTime)";
        DataTable TempDataTable = DbHelperSQL.FindTable(2, sql);

        DataRow[] myrow = new DataRow[TempDataTable.Rows.Count];
        TempDataTable.Rows.CopyTo(myrow, 0);

        double[] myValue = Array.ConvertAll(myrow, new Converter<DataRow, double>(ConvertOriginToDouble));
            int num = 5;//待预测数据个数
            ES es1 = new ES(myValue, num, 0.8);
            double[] result = es1.ES_SecResult();

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
                    dr[2] = Math.Round(result[i],0).ToString();//将预测值四舍五入为整数
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
    }
 }
}
