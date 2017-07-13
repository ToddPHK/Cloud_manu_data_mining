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

namespace CloudSAS
{
    public partial class userMgr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                this.InfoBind();
            }
        }
        //信息绑定
        protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
        {
            this.InfoBind();
        }

        protected void InfoBind()
        {
            //userinfoMgr mgr = new userinfoMgr();
            //userinfoDao uDao=new userinfoDao();
            //e.Total = int.Parse(mgr.GetCount_userinfo(""));
            //IList<userinfo> list=mgr.FindAllByPage_userinfo(e.Start.ToString(),e.Limit.ToString(),"");
            Store store = this.GridPanel1.GetStore();
            string sql = "select UserID as userid,userName as username,userPass as password,roleid,Telephone as telephone,Adress as address,eMail as email,logintime ,RegisterTime as createtime from UserInfor where UserState='1' ORDER BY UserID ASC";
            //IList<userinfo> list = uDao.FindAllUser();
            store.DataSource = DBUtility.DbHelperSQL.FindTable(2, sql);
            //Store1.DataSource = list;
            //Store1.DataBind();
            store.DataBind();
        }
        //获取所有角色，与用户角色ID做映射
        protected void GetAllRoles(object sender, StoreReadDataEventArgs e)
        {
            //rolesMgr mgr = new rolesMgr();
            string sql = "select roleid,rolename FROM roles ORDER BY roleid ASC";
            //S_Roles.DataSource = mgr.FindAll_roles();
            S_Roles.DataSource = DBUtility.DbHelperSQL.FindTable(3, sql);
            S_Roles.DataBind();
        }
        //双击Grid的列，弹出修改框
        protected void GridDBClick(object sender, DirectEventArgs e)
        {
            userinfoMgr mgr = new userinfoMgr();
            userinfo user = mgr.FindById_userinfo(int.Parse(e.ExtraParams["id"]));
            if (user != null)
            {
                TxtUserName.Text = user.username;
                TxtTel.Text = user.telephone;
                TxtEmail.Text = user.email;
                cboRole.Value = user.roleid;
                TxtAddress.Text = user.address;
                Hid.Text = user.userid.ToString();
                WinUser.Show();
            }
        }
        //重置选中用户密码
        //删除用户
        protected void BtnDel_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.GridPanel1.SelectionModel.Primary as RowSelectionModel;
            foreach (SelectedRow row in sm.SelectedRows)
            {
                userinfo user = new userinfo();
                user.userid = int.Parse(row.RecordID);
                if (row.RecordID == Session["currentUserID"].ToString())
                {
                    X.Msg.Notify("失败", "<font color='red'>系统不允许删除超级管理员!</font>").Show();
                    continue;
                }
                userinfoMgr mgr = new userinfoMgr();
                if (mgr.Del_userinfo(user))
                    X.Msg.Notify("成功", "<font color='green'>已经成功删除选中的用户</font>").Show();
                else
                    X.Msg.Notify("失败", "<font color='green'>删除用户失败，请您重试！</font>").Show();
            }
            GridPanel1.Reload();
        }
        //保存用户
        protected void BtnSave_Click(object sender, DirectEventArgs e)
        {
            userinfoMgr mgr = new userinfoMgr();
            if (Hid.Text.Length > 0)
            {//Update User
                userinfo user = mgr.FindById_userinfo(int.Parse(Hid.Text));
                user.roleid = int.Parse(cboRole.SelectedItem.Value);
                user.telephone = TxtTel.Text.Trim();
                user.email = TxtEmail.Text.Trim();
                user.address = TxtAddress.Text.Trim();
                if (mgr.Update_userinfo(user))
                {
                    WinUser.Hide();
                    X.Msg.Notify("成功", "用户修改成功").Show();
                    GridPanel1.Reload();
                }
                else
                    MsgShow("失败", "用户修改失败，请重试");
            }
            else
            {//ADD User
                if (mgr.FindById_userinfo(TxtUserName.Text.Trim()) != null)
                {
                    MsgShow("提示", "该用户已存在，请使用其他用户名"); return;
                }
                userinfo user = new userinfo();
                user.username = TxtUserName.Text.Trim();
                user.roleid = int.Parse(cboRole.SelectedItem.Value);
                user.telephone = TxtTel.Text.Trim();
                user.password = CJ_DBOperater.CJ.PwdSecurity("123456");
                user.logintime = DateTime.Now.ToString();
                user.createtime = DateTime.Now.ToString();
                user.email = TxtEmail.Text.Trim();
                user.address = TxtAddress.Text.Trim();
                if (mgr.Add_userinfo(user))
                {
                    WinUser.Hide();
                    X.Msg.Notify("成功", "<font color='green'>用户添加成功，默认密码123456</font>").Show();
                    GridPanel1.Reload();
                }
                else
                    MsgShow("失败", "用户添加失败，请重试");
            }
        }
        //弹出提示框方法
        public void MsgShow(string title, string infos)
        {
            X.Msg.Show(new MessageBoxConfig
            {
                Title = title,
                Message = infos,
                Buttons = MessageBox.Button.OK,
                Icon = MessageBox.Icon.INFO
            });
        }
        //导出Grid到Excel
        protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
        {
            string format = this.FormatType.Value.ToString();

            XmlNode xml = e.Xml;

            this.Response.Clear();

            switch (format)
            {
                case "xml":
                    string strXml = xml.OuterXml;
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
                    this.Response.AddHeader("Content-Length", strXml.Length.ToString());
                    this.Response.ContentType = "application/xml";
                    this.Response.Write(strXml);
                    break;

                case "xls":
                    this.Response.ContentType = "application/vnd.ms-excel";
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
                    XslCompiledTransform xtExcel = new XslCompiledTransform();
                    xtExcel.Load(Server.MapPath("../Excel.xsl"));
                    xtExcel.Transform(xml, null, Response.OutputStream);

                    break;

                case "csv":
                    this.Response.ContentType = "application/octet-stream";
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
                    XslCompiledTransform xtCsv = new XslCompiledTransform();
                    xtCsv.Load(Server.MapPath("../Csv.xsl"));
                    xtCsv.Transform(xml, null, Response.OutputStream);

                    break;
            }
            this.Response.End();
        }
    }
}
