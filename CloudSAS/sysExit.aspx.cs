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

namespace CloudSAS
{
	/// <summary>
	/// exit ��ժҪ˵����
	/// </summary>
	public partial class sysExit : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// �ڴ˴������û������Գ�ʼ��ҳ��
			HttpCookie mycookie = Request.Cookies["userinfo"];
			mycookie.Values.Remove("Username");
			mycookie.Values.Remove("yhzcm");
			mycookie.Expires=DateTime.Now.AddDays(-1);
			Response.Cookies.Add(mycookie);
			Response.Write("<script language=javascript>");
			Response.Write("javascript:window.parent.location.href='index.aspx'");
			Response.Write("</script>");
		}

		#region Web ������������ɵĴ���
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: �õ����� ASP.NET Web ���������������ġ�
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// �����֧������ķ��� - ��Ҫʹ�ô���༭���޸�
		/// �˷��������ݡ�
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}
}
