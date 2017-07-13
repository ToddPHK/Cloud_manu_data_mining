using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using DBUtility;
using Ext.Net;
using System.Collections.Generic;

namespace CloudSAS
{

    public partial class servDealReport : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                string sql = "SELECT LEFT(ServiceID,1) ,COUNT(*) FROM deal_fact GROUP BY LEFT(ServiceID,1)";
                DataTable tmp1 = DbHelperSQL.FindTable(3, sql);
                sql = "SELECT ServiceID,EntUserInfor.EntFullName,eu2.EntFullName,price,DealDate,FinDate FROM deal_fact,EntUserInfor,EntUserInfor as eu2 WHERE deal_fact.Applicant=eu2.UserID and deal_fact.Publisher=EntUserInfor.UserID ORDER BY ServiceID ASC";
                DataTable tmp2 = DbHelperSQL.FindTable(3, sql);
                int len1 = tmp1.Rows.Count;
                //Response.Write(len1.ToString());
                List<object> data = new List<object>(len1);

                //char[] letterArray= new char[len1];
                //for (int tmp=0;tmp<len1;tmp++)
                //letterArray[tmp] = tmp1.Rows[tmp][0].ToString().ToCharArray()[0];
                int count = 0;
                for (int i = 0; i < len1; i++)
                {
                    int len2 = Int32.Parse(tmp1.Rows[i][1].ToString());
                    List<object> customers = new List<object>(len2);
                    char letter = tmp1.Rows[i][0].ToString().ToCharArray()[0];
                    for (int j = 1; j <= len2; j++)
                    {
                        customers.Add(new
                        {
                            ServiceID = tmp2.Rows[count][0].ToString(),
                            CompanyName = tmp2.Rows[count][1].ToString(),
                            ContactName = tmp2.Rows[count][2].ToString(),
                            Email = tmp2.Rows[count][3].ToString(),
                            Address = tmp2.Rows[count][4].ToString(),
                            City = tmp2.Rows[count][5].ToString(),
                        });
                        count++;
                    }

                    data.Add(new { Letter = letter.ToString(), Customers = customers });
                    //letter++;
                }

                this.dsReport.DataSource = data;
                this.dsReport.DataBind();
            }

        }
    }
}
