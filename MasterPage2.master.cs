using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

public partial class MasterPage2 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //FillAccordion();
        //BindtoDataSet();
        //SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["Rent DevConnectionString"].ToString());
        SqlDataSourceMenu.ConnectionString = ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString();
        HiddenFieldUser.Value = GlobalMethods.GetUserID(Request.ServerVariables["AUTH_USER"]).ToString();
    }
    protected void RadMenu1_ItemCreated(object sender, RadMenuEventArgs e)
    {
       
       e.Item.BackColor= System.Drawing.ColorTranslator.FromHtml("#315B84");
       e.Item.ForeColor = System.Drawing.Color.White;
       e.Item.Font.Size = System.Web.UI.WebControls.FontUnit.Medium;
       e.Item.BorderColor = System.Drawing.Color.White;
       e.Item.BorderWidth = 1;
    }
    protected long GetUserID()
    {
        WebFunctions obj = new WebFunctions();
        string user = Request.ServerVariables["AUTH_USER"];
        long authUserID = obj.GetSOPUserID(user);
        return authUserID;
    }

    private void BindtoDataSet()
    {
        //string cmdtext = "";
        //SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["Rent DevConnectionString"].ToString());
        //SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        //cmdtext = "sp_Sys_WebMenu @UserID";
        //cmd.CommandText = cmdtext;
        //cmd.Parameters.Add(new SqlParameter("@UserID", GlobalMethods.GetUserID(Request.ServerVariables["AUTH_USER"])));
        //SqlDataAdapter adapter = new SqlDataAdapter(cmd);

        //------------------------------using Datasource---------------------------------------------------------------------
        //SqlDataSource SQLDSMenu = (SqlDataSource)SqlDataSourceMenu;
        //SQLDSMenu.ConnectionString = ConfigurationManager.ConnectionStrings["Rent DevConnectionString"].ToString();
        //SQLDSMenu.SelectCommand = "sp_Sys_WebMenu @UserID";
        //SQLDSMenu.SelectParameters.Add("@UserID", GlobalMethods.GetUserID(Request.ServerVariables["AUTH_USER"]).ToString());
        //SQLDSMenu.DataSourceMode = SqlDataSourceMode.DataReader;
        //RadMenu1.DataSource = SQLDSMenu;
        //RadMenu1.DataBind();
        //Dbconn.Open();
        //DataSet links = new DataSet();
        //adapter.Fill(links);

        //links.EnforceConstraints = false;

        //RadMenu1.DataTextField = "MenuDesc";
        //RadMenu1.DataNavigateUrlField = "MenuCommand";
        //RadMenu1.DataFieldID = "ID";
        //RadMenu1.DataFieldParentID = "ParentID";



        ////Style RadMenu
        ////System.Drawing.Color color = System.Drawing.ColorTranslator.FromHtml("#023467");
        //RadMenu1.BackColor = System.Drawing.ColorTranslator.FromHtml("#315B84"); //#315B84
        //RadMenu1.DataSource = links;
        //RadMenu1.DataBind();

    }
}
