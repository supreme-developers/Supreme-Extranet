using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Data;
using Telerik.Web.UI;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;

using System.Security;
using System.Web.Security;





public partial class STIM_CertImageOrder : System.Web.UI.Page
{
    string login = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["CertID"] != null)
            {
                RadComboBoxCertNum.SelectedValue = Session["CertID"].ToString();
                RadComboBoxCertNum.DataBind();
                Session["CertID"] = null;
            }
        }

        HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
        if (!(authCookie == null))
        {
            //Following code removes logged in cookie
            //authCookie.Expires = DateTime.Now.AddDays(-1D);
            //Response.Cookies.Add(authCookie);

            //Get Authentication Cookie
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
            string cookiePath = ticket.CookiePath;
            DateTime expiration = ticket.Expiration;
            bool expired = ticket.Expired;
            bool isPersistent = ticket.IsPersistent;
            DateTime issueDate = ticket.IssueDate;
            string name = ticket.Name;
            login = name;
            string userData = ticket.UserData;

            if (name == "")
            {
                Session["OrigUrl"] = "~/Stim/CertImageOrder.aspx";
                Response.Redirect("~/Login.aspx?" + Request.QueryString["nologin"].ToString());
            }
            else
            {
                LabelUSER.Text = "<b><i>" + name.ToUpper() + "</i></b>";
            }
        }
        else
        {
            Session["OrigUrl"] = "~/Stim/CertImageOrder.aspx";
            Response.Redirect("~/Login.aspx");
        }
    }

    protected void RadComboBoxCertNum_OnLoad()
    {
        
    }
   
    protected void Rotator1_ItemClick(object sender, RadRotatorEventArgs e)
    {
        Label lbl = e.Item.FindControl("LabelID") as Label;
        TextBoxImageOrder.Text = lbl.Text;
        RadListViewMainImage.DataBind();
    }
    protected void RadButtonMainImage_Click(object sender, EventArgs e)
    {
        //Response.Redirect("/Stim/CertImageOrder.aspx?");
        RadButton rbMainImage = (RadButton)sender;
        string imageId = rbMainImage.CommandArgument;
        string imageorder = rbMainImage.Attributes["ImageOrder"].ToString();

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_ImageLibrary set ImageOrder = @ImageOrder where ImageOrder = 1 and CertificationID = @CertificationID;" +
                         "Update tblSTIM_ImageLibrary " +
                         "Set ImageOrder = 1" +
                         "Where CertificationID = @CertificationID and ImageID = @ImageID";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@CertificationID", RadComboBoxCertNum.SelectedValue);
        cmd.Parameters.AddWithValue("@ImageOrder", imageorder);
        cmd.Parameters.AddWithValue("@ImageID", imageId);
        try
        {
            cmd.ExecuteNonQuery();
            Session["CertID"] = RadComboBoxCertNum.SelectedValue;
            Response.Redirect("CertImageOrder.aspx?");
            //ViewState.Add("CertID", RadComboBoxCertNum.SelectedValue);
            

            //need to get ID to update for rest of steps
        }
        catch (Exception ex)
        {

        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonUpload_Click(object sender, EventArgs e)
    {
        // CreateCert();

        //string cmdtext = "";
        //int counter = 0;
        //RadListView RadListView1 = (RadListView)FormViewPadEyes.FindControl("RadListView1");

        //int orderNumber = GetMaxImageOrderNum(Convert.ToInt32(TextBoxCertID.Text));

        //SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        //SqlCommand cmd = new SqlCommand();

        //foreach (UploadedFile file in RadAsyncUpload2.UploadedFiles)
        //{
        //    byte[] fileData = new byte[file.InputStream.Length];
        //    file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);

        //    cmdtext += "Insert into tblSTIM_ImageLibrary (BinaryImage,CertificationID,File_Name,File_Description,Uploaded_USERID,Uploaded_Datetime,ImageOrder)" +
        //               " values(@BinaryImage" + counter + ",@CertificationID,@File_Name" + counter + ",@File_Description" + counter + ",@Uploaded_USERID,@Uploaded_Datetime,@ImageOrder" + counter + ");";

        //    // "if exists(select Max(ImageOrder) from tblSTIM_ImageLibrary where CertificationID = @CertificationID)" +

        //    cmd.Parameters.Add("@BinaryImage" + counter, SqlDbType.Binary, -1);
        //    cmd.Parameters["@BinaryImage" + counter].Value = fileData;
        //    cmd.Parameters.AddWithValue("@File_Name" + counter, file.FileName);
        //    cmd.Parameters.AddWithValue("@File_Description" + counter, file.FileName);
        //    cmd.Parameters.AddWithValue("@ImageOrder" + counter, orderNumber + 1);
        //    counter++;
        //    orderNumber++;
        //}
        //cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        //cmd.Parameters.AddWithValue("@Uploaded_USERID", GlobalMethods.GetUserID(login));
        //cmd.Parameters.AddWithValue("@Uploaded_Datetime", DateTime.Now);

        //Dbconn.Open();
        //cmd.CommandText = cmdtext;
        //cmd.Connection = Dbconn;
        //try
        //{
        //    cmd.ExecuteNonQuery();
        //    LabelCustomerError.Text = "";
        //    //RadListView1.DataBind();
        //    LabelCustomerError.Visible = true;
        //}
        //catch (Exception ex)
        //{
        //    LabelCustomerError.Visible = true;
        //    LabelCustomerError.Text = ex.Message;
        //}
        //finally
        //{
        //    Dbconn.Close();
        //    Dbconn.Dispose();
        //    cmd.Dispose();
        //}
        ////Response.Redirect("http://localhost:61705/Intranet/STIM/CertificateofCompliance.aspx");

        ////sp_STIM_GetReportName"
        ////.Parameters.Refresh
        ////.Parameters("@CertTypeID") = Me.CertificationTypeID
        ////.Parameters("@MethodofInspectionID") = Me.MethodofInspectionID
    }
}