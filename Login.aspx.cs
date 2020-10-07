using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using Telerik.Web.UI;
using Telerik.Web.UI.Upload;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Diagnostics;
using System.Web.Security;
public partial class Login : System.Web.UI.Page
{
    static string prevPage = String.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //TextBox tbox = Login2.FindControl("UserName") as TextBox;

        //if (tbox != null)
        //{
        //    ScriptManager.GetCurrent(this.Page).SetFocus(tbox);
        //}
        //if (!IsPostBack)
        //{
        //    prevPage = Request.Url.ToString();
            
        //}
       
    }
    private bool SiteSpecificAuthenticationMethod(string UserName, string Password)
    {
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        CheckBox cek = (CheckBox)Login2.FindControl("RememberMe");
        string cmdtext = "Select FirstName,LastName,USERID,[User] from usysPasswords where [User] = @User and Password = @Password";
       
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@User", UserName);
        cmd.Parameters.AddWithValue("@Password", Password);

        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                Session["Name"] = dr["FirstName"].ToString() + " " + dr["LastName"].ToString();
                Session["USERID"] = dr["USERID"].ToString();
                Session["UserName"] = dr["User"].ToString();
                //FormsAuthentication.SetAuthCookie(Login2.UserName,true);
                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                 Login2.UserName,
                 DateTime.Now,
                 DateTime.Now.AddMinutes(120),
                 false,"ApplicationSpecific data for this user.",
                 FormsAuthentication.FormsCookiePath);
                //encrypt ticket
                string encTicket = FormsAuthentication.Encrypt(ticket);
                Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));
                //if (cek.Checked)
                //{
                //    HttpCookie cookie = new HttpCookie("username");
                //    cookie.Value = Login2.UserName;

                //    cookie.Expires = DateTime.Now.AddDays(1);//cookie Expires
                //    HttpContext.Current.Response.AppendCookie(cookie);
                //}
                return true;

            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }

    protected void OnAuthenticate(object sender, AuthenticateEventArgs e)
    {
        e.Authenticated = SiteSpecificAuthenticationMethod(Login2.UserName, Login2.Password);

       // string url = HttpContext.Current.Request.Url.AbsolutePath;

        if (e.Authenticated && Session["OrigUrl"] != null)
        {
            Response.Redirect(Session["OrigUrl"].ToString());
        }
        else 
        {
            if (e.Authenticated)
                Response.Redirect("Default.aspx");
            else
            {
                Login2.FailureText = "The User Name and/or Password is not correct";
                Login2.FailureAction = LoginFailureAction.RedirectToLoginPage;
            }
        }
    }


}