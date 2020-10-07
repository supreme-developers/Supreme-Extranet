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
using System.Drawing.Imaging;
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
                RadRotator1.DataBind();
            }
            else
            {
                    PanelPushImages.Visible = false;
                    RadButtonCreateNew.Visible = false;
            }
        }

        lblCertID.Text = RadComboBoxCertNum.SelectedValue.ToString() + "f";
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

    protected void RadButton1_Click(object sender, EventArgs e)
    { 
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "sp_STIM_PushImages @CertificationID";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@CertificationID", RadComboBoxCertNum.SelectedValue);
        try
        {
            cmd.ExecuteNonQuery();
            Session["CertID"] = RadComboBoxCertNum.SelectedValue;
            Response.Redirect("CertImageOrder.aspx?");
        }

        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error Pushing Images", "alert('There was an error pushing the images through. Please try again or email the help desk the following error: " + ex.Message + "'); ", true);
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
    private int GetMaxImageOrderNum(int CertID)
    {
        string cmdtext;
        int ID;
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        cmdtext = "Select isnull(max(imageorder),0) as 'order' from tblstim_imagelibrary where CertificationID = @CertificationID";

        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@CertificationID", CertID);

        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                ID = Convert.ToInt32(dr["order"].ToString());
            }
            else
                ID = 0;
        }
        catch (Exception ex)
        {
            ID = 0;
        }

        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
        return ID;
    }
    protected void RadButtonUpload_Click(object sender, EventArgs e)
    {
            string cmdtext = "";
            int counter = 0;
            // RadListView RadListView1 = (RadListView)FormViewPadEyes.FindControl("RadListView1");

            int orderNumber = GetMaxImageOrderNum(Convert.ToInt32(RadComboBoxCertNum.SelectedItem.Value));

            SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
            SqlCommand cmd = new SqlCommand();

            //System.Drawing.Image uploaded = System.Drawing.Image.FromStream(FileUpload1.PostedFile.InputStream);
            //byte[] fileData;
            //using (MemoryStream mso = new MemoryStream())
            //{
            //    ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().FirstOrDefault(c => c.FormatID == ImageFormat.Jpeg.Guid);
            //    EncoderParameters jpegParms = new EncoderParameters(1);
            //    jpegParms.Param[0] = new EncoderParameter(Encoder.Quality, 95L);
            //    uploaded.Save(mso, codec, jpegParms);
            //    fileData = mso.ToArray();
            //}

            foreach (UploadedFile file in RadUpload1.UploadedFiles)
            {
            
                byte[] fileData = new byte[file.InputStream.Length];
                file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);

                cmdtext += "Insert into tblSTIM_ImageLibrary (BinaryImage,CertificationID,File_Name,File_Description,Uploaded_USERID,Uploaded_Datetime,ImageOrder)" +
                           " values(@BinaryImage" + counter + ",@CertificationID,@File_Name" + counter + ",@File_Description" + counter + ",@Uploaded_USERID,@Uploaded_Datetime,@ImageOrder" + counter + ");" +
                           " Insert into [www.stimservices.com].FileDownload.dbo.tblSTIM_ImageLibrary(BinaryImage,CustomerFileID,[File_Name]," +
                           " File_Description,Uploaded_UserID,Uploaded_Datetime,CertificationNumber,CertificationDate,SpecificationNumber,ImageOrder)" +
                           " select @BinaryImage" + counter + ", S.CustomerFileID, @File_Name" + counter + ",@File_Description" + counter + ", @Uploaded_USERID, @Uploaded_Datetime," +
                           " R.CertificationNumber, R.CertificationDate, Spec.SpecificationNumber,@ImageOrder" + counter + 
                           " From tblSTIM_Certification R " +
                           " inner join [www.stimservices.com].FileDownload.dbo.tbl_customerfiles S on R.CertificationNumber = S.CertNumber " +
                           " left join tblSTIM_Certification_SpecificationNumber Spec on R.SpecificationNumberID = Spec.SpecificationNumberID " +
                           " Where R.CertificationID = @CertificationID and S.Status = 'O' and S.SerialNumber = R.ItemNumber and S.CertTypeID = R.MethodofInspectionID ;";

                cmd.Parameters.Add("@BinaryImage" + counter, SqlDbType.Binary, -1);
                cmd.Parameters["@BinaryImage" + counter].Value = fileData;
                cmd.Parameters.AddWithValue("@File_Name" + counter, file.FileName);
                cmd.Parameters.AddWithValue("@File_Description" + counter, file.FileName);
                cmd.Parameters.AddWithValue("@ImageOrder" + counter, orderNumber + 1);
                counter++;
                orderNumber++;
            }
            cmd.Parameters.AddWithValue("@CertificationID", RadComboBoxCertNum.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@Uploaded_USERID", GlobalMethods.GetUserID(login));
            cmd.Parameters.AddWithValue("@Uploaded_Datetime", DateTime.Now);

            Dbconn.Open();
            cmd.CommandText = cmdtext;
            cmd.Connection = Dbconn;
            try
            {
                cmd.ExecuteNonQuery();
                LabelCustomerError.Text = "";
                //RadListView1.DataBind();
                LabelCustomerError.Visible = true;
                Session["CertID"] = RadComboBoxCertNum.SelectedValue;
                Response.Redirect("CertImageOrder.aspx?");

            }
            catch (Exception ex)
            {
                LabelCustomerError.Visible = true;
                LabelCustomerError.Text = ex.Message;
            }
            finally
            {
                Dbconn.Close();
                Dbconn.Dispose();
                cmd.Dispose();
            }
    }
    protected void RadComboBoxCertNum_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadRotator1.DataBind();
        RadButtonCreateNew.Visible = true;
        //the following query checks for images on SSIRENT that are not at stimservices.com
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "select Distinct C.CertificationID From  tblSTIM_Certification C inner join tblSTIM_ImageLibrary I  on C.CertificationID = I.CertificationID" +
                         " inner join [www.stimservices.com].FileDownload.dbo.tbl_customerfiles S on C.CertificationNumber = S.CertNumber " +
                        // " left join tblSTIM_Certification_SpecificationNumber Spec on C.SpecificationNumberID = Spec.SpecificationNumberID" +
                         " where S.Status = 'O' and S.SerialNumber = C.ItemNumber and S.CertTypeID = C.MethodofInspectionID " +
                         " and C.CertificationID = @CertificationID group by C.CertificationNumber,C.CertificationID,S.CUstomerFileID " +
                         " having COUNT(I.ImageID) > (select COUNT(ImageID) from [www.stimservices.com].FileDownload.dbo.tblstim_ImageLibrary SI where SI.CustomerFileID = S.CustomerFileID)";

        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@CertificationID", RadComboBoxCertNum.SelectedValue);
        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                PanelPushImages.Visible = true;
            }
            else
            {
                PanelPushImages.Visible = false;
            }
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


        RadButtonCreateNew.Visible = true;
    }
}