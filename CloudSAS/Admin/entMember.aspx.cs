using System;
using System.Data;
using Ext.Net;
using Model;
using DBUtility;

namespace CloudSAS
{
    public partial class entMember : System.Web.UI.Page
    {
        private string _dbName;
        public string dbName
        {
            get { return _dbName; }
            set { _dbName = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            dbName = "PT_" + Request.Cookies["Userinfo"]["Username"].ToString();
            if (!X.IsAjaxRequest)
            {
                this.BindData();
            }

        }
        protected void RowSelect(object sender, DirectEventArgs e)
        {
            Employee model = new Employee();
            string employeeID = e.ExtraParams["EmployeeID"];
            //string dbName="PT_clientleo";
            string sql = "SELECT 人员编号 as EmployeeNumber, EmployeeList.人员名称 as FullName, 性别 as Gender,学历 as degree, 移动电话 as MobilePhone,归属部门 as DepartmentNumber, 归属角色 as Position, 出生年月 as BirthDate, 通讯地址 as Address, Email, 培训情况 as BriefIntroduction, 进厂日期 as HireDate FROM EmployeeList WHERE 人员编号='"+employeeID+"'";
            DataTable dt = DbHelperSQL.FindTable(dbName, sql);
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
        }

        protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
        {
            this.BindData();
        }

        private void BindData()
        {
            Store store = this.GridPanel1.GetStore();

            string sql = "SELECT 人员编号 as EmployeeID, EmployeeList.人员名称 as FullName FROM EmployeeList ORDER BY EmployeeID ASC";
            store.DataSource = DBUtility.DbHelperSQL.FindTable(dbName, sql);
            store.DataBind();
        }

        //删除用户
        protected void BtnDel_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.GridPanel1.GetSelectionModel() as RowSelectionModel;


            //string msg = "";
            foreach (SelectedRow row in sm.SelectedRows)
            //foreach (Ext.Net.ListItem item in items1)
            {
                //string userid = dt.Rows[int.Parse(row.RecordID)-1][0].ToString();
                string userid =row.RecordID;
                string sql = "DELETE FROM EmployeeList WHERE 人员编号='"+userid+"'";
                DbHelperSQL.ExecuteSql(dbName, sql);

            }

            this.BindData();//刷新数据
        }
    }
}
