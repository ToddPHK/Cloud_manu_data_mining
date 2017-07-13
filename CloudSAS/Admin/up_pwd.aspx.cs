using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using DBUtility;

namespace CloudSAS.Admin
{
	/// <summary>
	/// up_pwd 的摘要说明。
	/// </summary>
	public partial class up_pwd : System.Web.UI.Page
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// 在此处放置用户代码以初始化页面
			if (!IsPostBack)
			{
				string yhzcm_zcm=Request.Cookies["Userinfo"]==null?"":Request.Cookies["Userinfo"]["Username"].ToString();
				UserID.Text=yhzcm_zcm;
			}
		}

		#region Web 窗体设计器生成的代码
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: 该调用是 ASP.NET Web 窗体设计器所必需的。
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// 设计器支持所需的方法 - 不要使用代码编辑器修改
		/// 此方法的内容。
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

		protected void Submit1_ServerClick(object sender, System.EventArgs e)
		{
			//CloudSAS_adminUser my  = new CloudSAS_adminUser();
            string sql = "update UserInfor set userPass ='" + New_Pwd.Text + "' where UserName='" + UserID.Text + "'";
            DbHelperSQL.ExecuteSql(2, sql);
			//my.up_pwd(UserID.Text,New_Pwd.Text);
			//ShowMsg.Text="修改密码成功！";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language=javascript> window.alert('密码修改成功！');</script>");
		}
	}
}
