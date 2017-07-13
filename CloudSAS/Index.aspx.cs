using System;
using System.Data;
using System.Web;
using DBUtility;
using Ext.Net;
using Model;

namespace CloudSAS
{
    /// <summary>
    /// WebForm1 ��ժҪ˵����
    /// </summary>
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            // �ڴ˴������û������Գ�ʼ��ҳ��

        }


        protected void Button1_Click(object sender, System.EventArgs e)
        {
            if (Request["UserName"].ToString().Trim() == "" || Request["Pwd"].ToString().Trim() == "")
            {
                X.Msg.Alert("��ʾ", "�û��������벻��Ϊ�գ�").Show();
            }
            else
            {
                //ArrayList userinfo = new ArrayList();
                //userinfo.Add(Request["UserName"].ToString());
                //userinfo.Add(Request["Pwd"].ToString());
                //User_Contrl Ulogin = new User_Contrl();
                //IDataReader Rs=Ulogin.User_Login(userinfo);
                string strSQL = "select * from UserInfor where userName='" + Request["UserName"].ToString() + "' and userPass='" + Request["Pwd"].ToString() + "'";
                IDataReader Rs = DbHelperSQL.ExecuteReader(2, strSQL);
                if (Rs.Read())
                {
                    userinfo model = new userinfo();
                    //DataTable dt = DbHelperSQL.FindByConditions(2, model, "username='" + Rs["userName"].ToString() + "'");
                    //string sql;
                    string sql = "SELECT UserID,userName,userPass as password,roleid,Telephone,Adress as address,eMail,logintime,RegisterTime as createtime from UserInfor WHERE userName='" + Rs["userName"].ToString() + "'";
                    DataTable dt = DbHelperSQL.FindTable(2, sql);
                    userinfo user = Common<userinfo>.Dt2Model(model, dt);

                    //======================================================================
                    HttpCookie mycookie = new HttpCookie("Userinfo");
                    mycookie["role"] = Rs["roleid"].ToString().Trim();
                    mycookie["UserID"] = user.userid.ToString();
                    mycookie["Username"] = user.username;
                    mycookie["yhzcm"] = Rs["userPass"].ToString();
                    mycookie["userpwd"] = Rs["userPass"].ToString();
                    //mycookie["qx"]=Rs["privilege"].ToString();
                    //mycookie["cg"]=Rs["isAdmin"].ToString();
                    //mycookie["bmbm"]=Rs["bmbm"].ToString();
                    //mycookie["bmnr"]=Rs["bmnr"].ToString();
                    mycookie.Expires = DateTime.Now.AddDays(1);
                    Response.Cookies.Add(mycookie);
                    sql = "UPDATE UserInfor SET logintime=getdate() where userName='" + user.username + "'";
                    //�����ݿ�CloudMDB�ı�UserInfor��[logintime]�ֶ��м�¼��ǰ�û���¼ʱ��
                    DbHelperSQL.ExecuteSql(2, sql);
                    Rs.Close();
                    Rs.Dispose();
                    //Response.Redirect("main.htm");
                    Response.Redirect("main.aspx");
                }
                else
                {
                    Rs.Close();
                    Rs.Dispose();
                    X.Msg.Alert("��ʾ", "�û������������").Show();
                }
            }
        }
    }
}
