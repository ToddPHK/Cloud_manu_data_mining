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

namespace CloudSAS{

public partial class map : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "SELECT p.cha, u.LocateRegion AS province, Count(u.EntFullName) AS [count] FROM EntUserInfor as u LEFT JOIN province as p ON u.LocateRegion=p.name GROUP BY p.cha, u.LocateRegion ORDER BY [count] DESC";
        //DataTable TempDataTable = new DataTable();
        DataTable TempDataTable = DbHelperSQL.FindTable(3, sql);
        //TempDataTable.Columns.Add("Name");
        //TempDataTable.Columns.Add("Age");
        //TempDataTable.Columns.Add("Address");
        sql = "SELECT p.cha, u.EntFullName FROM EntUserInfor as u LEFT JOIN province as p ON u.LocateRegion=p.name ";
        DataTable TempDataTable2 = DbHelperSQL.FindTable(3, sql);
            /////////////////////////////////////////////////////////////////////
            JSON_Class Object_JSON_Class = new JSON_Class();
            ///////// JSON String with Rows And Cols////////////////////////////
            JSON_DataTable_DataHolder.Value= Object_JSON_Class.JSON_DataTable(TempDataTable);
            JSON_DataTable_DataHolder2.Value = Object_JSON_Class.JSON_DataTable(TempDataTable2);
            ///////// JSON String with Rows And ColNames////////////////////////////
            //JSON_Parameter_DataHolder.Value= Object_JSON_Class.CreateJsonParameters(TempDataTable);




    }
 }
}
