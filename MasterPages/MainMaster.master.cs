using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPages_MainMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["USERID"] == null)
        {
            Session["OrigUrl"] = Request.Url.ToString();
            Response.Redirect("Login.aspx?");
        }
    }
}
