

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

namespace Gdshare.Admin
{
	/// <summary>
	/// top 的摘要说明�?
	/// </summary>
	public partial class top : System.Web.UI.Page
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// 在此处放置用户代码以初始化页�?
			string yhzcm_zcm=Request.Cookies["Userinfo"]==null?"":Request.Cookies["Userinfo"]["yhzcm"].ToString();
			if(yhzcm_zcm=="")
			{
				Response.Write("<script language=javascript>");
				Response.Write("javascript:window.parent.location.href='index.aspx'");
				Response.Write("</script>");
			}
			else
			{
				yhzcm.Text=Request.Cookies["Userinfo"]["Username"].ToString();
			}
		}

		#region Web 窗体设计器生成的代码
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: 该调用是 ASP.NET Web 窗体设计器所必需的�?
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// 设计器支持所需的方�?- 不要使用代码编辑器修�?
		/// 此方法的内容�?
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}
}
