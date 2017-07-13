using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Ext.Net;
using System.Web.Caching;
using Model;
using System.Collections.Generic;
using BLL;
using System.IO;
using DBUtility;


namespace CloudSAS
{
    public partial class backMgr : System.Web.UI.Page
    {
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            if (Request.Cookies["Userinfo"]["Username"] == null || Request.Cookies["Userinfo"]["role"] == null)
                Response.Redirect("Index.aspx");
    
            this.ResourceManager1.DirectEventUrl = this.Request.Url.AbsoluteUri;

            // Reset the Session Theme on Page_Load.
            // The Theme switcher will persist the current theme only 
            // until the main Page is refreshed.
            if (this.Session["clearTheme"] == null)
            {
                this.Session["Ext.Net.Theme"] = Ext.Net.Theme.Gray;
            }
            else
            {
                Theme theme = Ext.Net.Theme.Gray;

                if (this.Session["Ext.Net.Theme"] != null)
                {
                    theme = (Theme)this.Session["Ext.Net.Theme"];
                }
                
                this.Session.Remove("clearTheme");
                GrayThemeItem.Checked = false;
                ((Ext.Net.CheckMenuItem)this.FindControl(theme.ToString() + "ThemeItem")).Checked = true;
            }
            
        }
        
        /*
        protected void BtnSave_Click(object sender, DirectEventArgs e)
        {
            if (TxtNewPwd.Text.Trim().Length <= 0 || TxtOldPwd.Text.Trim().Length <= 0)
            {
                MsgShow("提示", "信息不完整！");
                return;
            }
            if (TxtSurePwd.Text != TxtNewPwd.Text)
            { MsgShow("提示", "两次新密码输入不一致！"); return; }
            userinfoMgr userinfoMgr = new userinfoMgr();
            userinfo user = userinfoMgr.FindById_userinfo(Session["username"].ToString());
            //Md5+盐值加密算法，相对安全
            if (user != null && user.password.Trim() == CJ_DBOperater.CJ.PwdSecurity(Server.UrlEncode(this.TxtOldPwd.Text.Trim().Replace("'", ""))))
            {
                user.password = CJ_DBOperater.CJ.PwdSecurity(Server.UrlEncode(this.TxtSurePwd.Text.Trim().Replace("'", "")));
                if (userinfoMgr.Update_userinfo(user))
                {
                    MsgShow("成功", "密码修改成功，请重新登录系统！");
                    Response.Redirect("Index.aspx");
                    return;
                }
                MsgShow("错误", "密码修改失败，请重试！");
            }
            else
                MsgShow("错误", "旧密码错误，请重新输入！");
        }
         */
        //退出系统
        protected void BtnExit_Click(object sender, DirectEventArgs e)
        {
            Session.Clear();
            Response.Redirect("Index.aspx");
        }

        protected void Button2_Click(object sender, DirectEventArgs e)
        {
            X.Msg.Confirm("确认", "确实要退出系统吗？", new MessageBoxButtonsConfig
            {
                Yes = new MessageBoxButtonConfig
                {
                    Handler = "App.direct.DoYes()",
                    Text = "是"
                },
                No = new MessageBoxButtonConfig
                {
                    //Handler = "backMgr.DoNo()",
                    Text = "否"
                }
            }).Show();  
        }

        protected void DoYes()
        {
            Session.Clear();
            Response.Redirect("Index.aspx");

        }
        /// <summary>
        /// 获取用户角色功能菜单树
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void NodeLoad(object sender, NodeLoadEventArgs e)
        {
            if (e.NodeID == "root")
            {
                rolefunMgr rolefunMgr = new rolefunMgr();
                if (Request.Cookies["Userinfo"]["role"] != null && Request.Cookies["Userinfo"]["role"].ToString().Trim().Length > 0)
                    e.Nodes = rolefunMgr.GetMenu(3,Request.Cookies["Userinfo"]["role"].ToString().Trim());
                string sql = "select privilege from UserInfor where UserID=" + Request.Cookies["Userinfo"]["UserID"].ToString().Trim();
                if(DbHelperSQL.FindTable(2, sql).Rows[0][0].ToString().Length>0)//判断该用户是否有已购买的功能模块
                exampleTree.GetRootNode().AppendChild(rolefunMgr.GetPaidFun(2, Request.Cookies["Userinfo"]["UserID"].ToString().Trim()));
            }

        }


        /*
        public void MsgShow(string title, string infos)
        {
            X.Msg.Show(new MessageBoxConfig
            {
                Title = title,
                Message = infos,
                Buttons = MessageBox.Button.OK,
                Icon = MessageBox.Icon.INFO,
                AnimEl = this.BtnSave.ClientID
            });
            
        }
        */
    }
}
