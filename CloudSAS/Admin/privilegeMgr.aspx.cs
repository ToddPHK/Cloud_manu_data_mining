using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using BLL;
using Ext.Net;
using System.Xml;
using System.Xml.Xsl;
using System.Collections.Generic;
using Model;
using DBUtility;

namespace CloudSAS.Admin
{
    public partial class privilegeMgr : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                this.BindData();
            }

        }

        protected void LoadTree(Ext.Net.NodeCollection rootNode,string userID)
        {
            if (rootNode == null)
            {
                rootNode = new Ext.Net.NodeCollection();
            }
            rolefunMgr rolefunMgr = new rolefunMgr();
            TreePanel1.GetRootNode().RemoveAll();
            TreePanel1.GetRootNode().AppendChild(rolefunMgr.GetAllFun(3, Request.Cookies["Userinfo"]["role"].ToString().Trim()));
            TreePanel1.GetRootNode().Expand(true);
        }

        protected void RowSelect(object sender, DirectEventArgs e)
        {
            Employee model = new Employee();
            string userID = e.ExtraParams["userID"];
            //X.Msg.Alert("userID", userID).Show();//成功获取userID
            tmpUserID.SetValue(userID);
            LoadTree(TreePanel1.Root,userID);
            //tmpUserID.Value.ToString();
            /*
            //string dbName="PT_clientleo";
            string sql = "SELECT 人员编号 as EmployeeNumber, EmployeeList.人员名称 as FullName, 性别 as Gender,学历 as degree, 移动电话 as MobilePhone,归属部门 as DepartmentNumber, 归属角色 as Position, 出生年月 as BirthDate, 通讯地址 as Address, Email, 培训情况 as BriefIntroduction, 进厂日期 as HireDate FROM EmployeeList WHERE 人员编号='"+userID+"'";
            DataTable dt = DbHelperSQL.FindTable(2, sql);
            //Model.Employee empl = Model.Employee.GetEmployee(int.Parse(employeeID));
            Model.Employee empl = Common<Employee>.Dt2Model(model, dt);
            DateTime BirthDate = Convert.ToDateTime(empl.BirthDate);
            DateTime HireDate = Convert.ToDateTime(empl.HireDate);
            
            this.FormPanel1.SetValues(new
            {
                empl.EmployeeNumber,
                empl.FullName,
                empl.Position,  
                empl.degree,
                HireDate,
                empl.DepartmentNumber,
                empl.Address,
                empl.Email,
                empl.MobilePhone,
                empl.Gender,
                BirthDate,
                empl.BriefIntroduction
            });
             * */
        }

        protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
        {
            this.BindData();
        }

        private void BindData()
        {
            Store store = this.GridPanel1.GetStore();

            string sql = "SELECT UserID as userID, userName as userName FROM UserInfor WHERE UserState='1' ORDER BY UserID ASC";
            store.DataSource = DBUtility.DbHelperSQL.FindTable(2, sql);
            store.DataBind();
        }

        //删除用户
        protected void BtnDel_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.GridPanel1.GetSelectionModel() as RowSelectionModel;
            //RowSelectionModel sm = this.GridPanel1.SelectionModel.Primary as RowSelectionModel;
            //string sql = "SELECT 人员编号 as EmployeeNumber FROM EmployeeList ORDER BY EmployeeNumber ASC";
            //DataTable dt = DbHelperSQL.FindTable(dbName, sql);

            //string msg = "";
            foreach (SelectedRow row in sm.SelectedRows)
            //foreach (Ext.Net.ListItem item in items1)
            {
                //string userid = dt.Rows[int.Parse(row.RecordID)-1][0].ToString();
                string userid = row.RecordID;
                string sql = "DELETE FROM EmployeeList WHERE 人员编号='" + userid + "'";
                DbHelperSQL.ExecuteSql(2, sql);
                //msg = msg+userid;
                //string msg = userid;
                //X.Msg.Alert("提示", msg).Show();
                //userinfoMgr mgr = new userinfoMgr();
                //mgr.Del_userinfo(user);
            }
            //X.Msg.Alert("提示", msg).Show();
            //GridPanel1.Reload();
            this.BindData();//刷新数据
        }
    }
}
