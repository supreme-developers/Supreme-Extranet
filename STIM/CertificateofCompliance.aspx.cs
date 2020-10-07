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
using System.Security;
using System.Web.Security;

public partial class STIM_CertificateofCompliance : System.Web.UI.Page
{
   

    string login = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //TextBoxCertID.Text = "19593";
        //TextBoxUser.Text = Request.ServerVariables["AUTH_USER"].ToString();
        //TextBoxUser.Visible = true;
        //TextBoxUser.Visible = true;
        //if (Page.User.Identity.IsAuthenticated)
        //    TextBoxUser.Text = "YES";

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
                Session["OrigUrl"] = "~/Stim/CertificateofCompliance.aspx";
                Response.Redirect("~/Login.aspx?" + Request.QueryString["nologin"].ToString());
            }
            else
                LabelUSER.Text += "<b><i>" +  name.ToUpper() + "</i></b>";
        }
        else
        {
           Session["OrigUrl"] = "~/Stim/CertificateofCompliance.aspx";
           Response.Redirect("~/Login.aspx");
        }
       
        //string version = ticket.Version;
        //TextBoxUser.Text = Session["UserName"].ToString();
        //RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");
        //RadListView1.DataBind();
      //  RadListView RadListViewStep1 = step1Panel.FindControl("RadListViewStep1") as RadListView;
       // RadListViewStep1.ShowInsertItem();
       
        //BitmapImage bmpImage = new BitmapImage();
        //MemoryStream msImageStream = new MemoryStream();

        //msImageStream.Write(value, 0, value.Length);

        //bmpCardImage.BeginInit();
        //bmpCardImage.StreamSource = new MemoryStream(msImageStream.ToArray());
        //bmpCardImage.EndInit();

        //image.Source = bmpCardImage;
    }
    protected void SqlDataSourcePadEyes_Load(object sender, EventArgs e)
    {
        if (TextBoxCertID.Text != "" && RadTabStrip1.Tabs[2].Enabled)
        {
            TextBoxwhereClause.Text = String.Format(" where CertificationID = {0} ", TextBoxCertID.Text);
        }

    }

    protected void FormViewPadEyes_Load(object sender, EventArgs e)
    {
        Panel PanelMagPart = (Panel)FormViewPadEyes.FindControl("PanelMagPart");
    }
    
    protected void RadButtonStep1Next_Click(object sender, EventArgs e)
    {
        
        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");
        RadComboBox RadComboBoxInspectMeth = (RadComboBox)step1Panel.FindControl("RadComboBoxInspectMeth");
        RadDatePicker RadDatePickerCertDate = (RadDatePicker)step1Panel.FindControl("RadDatePickerCertDate");
        RadioButtonList RadioButtonListInventory = (RadioButtonList)step1Panel.FindControl("RadioButtonListInventory");
        RadTextBox RadTextBoxJobNum = (RadTextBox)step1Panel.FindControl("RadTextBoxJobNum");
        RadTextBox RadTextBoxJobLoc = (RadTextBox)step1Panel.FindControl("RadTextBoxJobLoc"); 
        RadComboBox RadComboBoxSpecNum = (RadComboBox)step1Panel.FindControl("RadComboBoxSpecNum");
        RadComboBox RadComboBoxBillingType = (RadComboBox)step1Panel.FindControl("RadComboBoxBillingType"); 
        RadTextBox RadTextBoxPONum = (RadTextBox)step1Panel.FindControl("RadTextBoxPONum");
        RadDatePicker RadDatePickerJobDate = (RadDatePicker)step1Panel.FindControl("RadDatePickerJobDate");
        RadComboBox RadComboBoxUnitNum = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitNum");
        RadComboBox RadComboBoxUnitDesc = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitDesc");
        
        //  RadListView RadListViewStep1 = step1Panel.FindControl("RadListViewStep1") as RadListView;
      

        //Insert statement here.
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification " +
                        " Set MethodofInspectionID = @MethodofInspectionID,CertificationDate = @CertificationDate," +
                         "InventoryID = @InventoryID,CompanyInventory = @CompanyInventory,ItemNumber = @ItemNumber,ItemDescription = @ItemDescription," +
                         "JobNumber = @JobNumber,JobLocation = @JobLocation,SpecificationNumberID = @SpecificationNumber," +
                         "JobDate = @JobDate, OfficeID = 5, FromWeb = 1" +
                         " Where CertificationID = @CertificationID";

        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@MethodofInspectionID", RadComboBoxInspectMeth.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificationDate", RadDatePickerCertDate.DbSelectedDate);

        if (RadioButtonListInventory.SelectedItem.Text == "Supreme")
        {
            cmd.Parameters.AddWithValue("@InventoryID", RadComboBoxUnitNum.SelectedValue);//Got to go get Inventory Item from Supreme
            cmd.Parameters.AddWithValue("@CompanyInventory", 1);
        }
        else
        {
            cmd.Parameters.AddWithValue("@InventoryID", DBNull.Value);
            cmd.Parameters.AddWithValue("@CompanyInventory", 2);
        }
        cmd.Parameters.AddWithValue("@ItemNumber", RadComboBoxUnitNum.Text);
        cmd.Parameters.AddWithValue("@ItemDescription", RadComboBoxUnitDesc.Text);//Gotta get desc if not customer unit
        
        cmd.Parameters.AddWithValue("@JobNumber", RadTextBoxJobNum.Text);
        cmd.Parameters.AddWithValue("@JobLocation", RadTextBoxJobLoc.Text);
        cmd.Parameters.AddWithValue("@SpecificationNumber", RadComboBoxSpecNum.SelectedValue);
        // cmd.Parameters.AddWithValue("@InvoiceItemID", RadComboBoxBillingType.SelectedValue);
        // cmd.Parameters.AddWithValue("@PONumber", RadTextBoxPONum.Text);
        cmd.Parameters.AddWithValue("@JobDate", RadDatePickerJobDate.DbSelectedDate);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        
        try
        {
            cmd.ExecuteNonQuery();
            //GetDefaultSchedule();
            GoToNextItem();
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
    protected void RadButtonStep2Next_Click(object sender, EventArgs e)
    {
        RadPanelItem Step2PanelItem = RadPanelBar1.FindItemByValue("Step2PanelItem");
        
        RadComboBox RadComboBoxTestingUnit = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxTestingUnit");
        RadTextBox RadTextBoxEmptyWeight = (RadTextBox)Step2PanelItem.FindControl("RadTextBoxEmptyWeight");  
        //RadComboBox RadComboBoxSlingType = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxSlingType");
        //RadComboBox RadComboBoxSlingSize = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxSlingSize");
        RadTextBox RadTextBoxWorkingLoad = (RadTextBox)Step2PanelItem.FindControl("RadTextBoxWorkingLoad");
        RadTextBox RadTextBoxTestedTo = (RadTextBox)Step2PanelItem.FindControl("RadTextBoxTestedTo");
        RadDatePicker RadDateManDate = (RadDatePicker)Step2PanelItem.FindControl("RadDateManDate");
        RadTextBox RadTextBoxMaxUnitCap = (RadTextBox)Step2PanelItem.FindControl("RadTextBoxMaxUnitCap");
        RadComboBox RadComboBoxMaxCap = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxMaxCap");
        RadTextBox RadTextDoubleMaxUnitCapacity = (RadTextBox)Step2PanelItem.FindControl("RadTextDoubleMaxUnitCapacity");
        RadTextBox RadTextBoxNumberofLegsEyes = (RadTextBox)Step2PanelItem.FindControl("RadTextBoxNumberofLegsEyes");
        RadComboBox RadComboBoxRejectionStatusID = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxRejectionStatusID");
        RadComboBox RadComboBoxMobile = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxMobile");

        //RadTextBox RadTextBox30Deg = (RadTextBox)Step2PanelItem.FindControl("RadTextBox30Deg");
        //RadTextBox RadTextBox45Deg = (RadTextBox)Step2PanelItem.FindControl("RadTextBox45Deg");
        //RadTextBox RadTextBox60 = (RadTextBox)Step2PanelItem.FindControl("RadTextBox60");

        //Insert statement here.
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set TestingMachineID = @TestingMachineID, EmptyWeight = @EmptyWeight, WorkingLoad = @WorkingLoad,TestedToPressure = @TestedToPressure," +
                         " ManufactureDate = @ManufactureDate,MaxUnitCapacity = @MaxUnitCapacity, MaxCapacity = @MaxCapacity, NumberofLegsEyes = @NumberofLegsEyes," +
                         " DoubleMaxUnitCapacity = @DoubleMaxUnitCapacity,RejectionStatusID = @RejectionStatusId, MobileTesting = @MobileTesting" +
                         " Where CertificationID = @CertificationID";


        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@TestingMachineID", RadComboBoxTestingUnit.SelectedValue);
        cmd.Parameters.AddWithValue("@EmptyWeight", RadTextBoxEmptyWeight.Text);
        //cmd.Parameters.AddWithValue("@SlingTypeID", RadComboBoxSlingType.SelectedValue);
        //cmd.Parameters.AddWithValue("@SlingSizeID", RadComboBoxSlingSize.SelectedValue);
        cmd.Parameters.AddWithValue("@WorkingLoad", RadTextBoxWorkingLoad.Text);
        cmd.Parameters.AddWithValue("@TestedToPressure", RadTextBoxTestedTo.Text);
        if (RadDateManDate.IsEmpty) 
            cmd.Parameters.AddWithValue("@ManufactureDate", DBNull.Value);
        else
            cmd.Parameters.AddWithValue("@ManufactureDate", RadDateManDate.SelectedDate);
        cmd.Parameters.AddWithValue("@MaxUnitCapacity", RadTextBoxMaxUnitCap.Text);
        cmd.Parameters.AddWithValue("@DoubleMaxUnitCapacity", RadTextDoubleMaxUnitCapacity.Text);
        cmd.Parameters.AddWithValue("@RejectionStatusId", RadComboBoxRejectionStatusID.SelectedValue);
        cmd.Parameters.AddWithValue("@MobileTesting", RadComboBoxMobile.SelectedValue);
        cmd.Parameters.AddWithValue("@MaxCapacity", RadComboBoxMaxCap.SelectedValue);
        cmd.Parameters.AddWithValue("@NumberofLegsEyes", RadTextBoxNumberofLegsEyes.Text);
        //cmd.Parameters.AddWithValue("@Degree30", RadTextBox30Deg.Text);
        //cmd.Parameters.AddWithValue("@Degree45", RadTextBox45Deg.Text);
        //cmd.Parameters.AddWithValue("@Degree60", RadTextBox60.Text);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        

        try
        {
            cmd.ExecuteNonQuery();
            GoToNextItem();
            //need to get ID to update for rest of steps
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonStep3Next_Click(object sender, EventArgs e)
    {
         RadPanelItem Step3PanelItem = RadPanelBar1.FindItemByValue("Step3PanelItem");
         RadComboBox RadComboBoxInspector = (RadComboBox)Step3PanelItem.FindControl("RadComboBoxInspector");
         RadComboBox RadComboBoxTestedBy = (RadComboBox)Step3PanelItem.FindControl("RadComboBoxTestedBy");
         RadComboBox RadComboBoxLevel = (RadComboBox)Step3PanelItem.FindControl("RadComboBoxLevel");
         RadComboBox RadComboBoxWitness = (RadComboBox)Step3PanelItem.FindControl("RadComboBoxWitness");   

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set InspectedByEmployeeID = @InspectedByEmployeeID, TestedByEmployeeID = @TestedByEmployeeID, InspectedLevelID = @InspectedLevelID, WitnessEmployeeID = @WitnessEmployeeID" +
                         " Where CertificationID = @CertificationID ";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@InspectedByEmployeeID", RadComboBoxInspector.SelectedValue);
        cmd.Parameters.AddWithValue("@TestedByEmployeeID", RadComboBoxTestedBy.SelectedValue);
        cmd.Parameters.AddWithValue("@InspectedLevelID", RadComboBoxLevel.SelectedValue);
        cmd.Parameters.AddWithValue("@WitnessEmployeeID", RadComboBoxWitness.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
            RadTabStrip1.Tabs[1].Enabled = true;
            RadTabStrip1.Tabs[1].Selected = true;

            RadMultiPage1.SelectedIndex = 1;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonStep4Next_Click(object sender, EventArgs e)
    {

        RadPanelItem Step4PanelItem = RadPanelBar1.FindItemByValue("Step4PanelItem");
        RadComboBox RadComboBoxRecurrence = (RadComboBox)Step4PanelItem.FindControl("RadComboBoxRecurrence");
        RadTextBox RadTextBoxRecurrenceQuantity = (RadTextBox)Step4PanelItem.FindControl("RadTextBoxRecurrenceQuantity");
        RadComboBox RadComboBoxUnitofMeasure = (RadComboBox)Step4PanelItem.FindControl("RadComboBoxUnitofMeasure");
       

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set RecurrenceType = @RecurrenceType, RecurrenceQuantity = @RecurrenceQuantity, SchedulingRecurrenceUOMID = @SchedulingRecurrenceUOMID" +
                         " Where CertificationID = @CertificationID ";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@RecurrenceType", RadComboBoxRecurrence.SelectedValue);
        cmd.Parameters.AddWithValue("@RecurrenceQuantity", RadTextBoxRecurrenceQuantity.Text);
        cmd.Parameters.AddWithValue("@SchedulingRecurrenceUOMID", RadComboBoxUnitofMeasure.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
            RadTabStrip1.Tabs[1].Enabled = true;
            RadTabStrip1.Tabs[1].Selected = true;
           
            RadMultiPage1.SelectedIndex = 1;
            //RadPageView2.Visible = true;
            //RadMultiPage1.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonStep5Next_Click(object sender, EventArgs e)
    {
        RadPanelItem Step5PanelItem = RadPanelBar2.FindItemByValue("Step5PanelItem");
        RadNumericTextBox RadNumericTextBoxTotalHours = (RadNumericTextBox)Step5PanelItem.FindControl("RadNumericTextBoxTotalHours");
        RadNumericTextBox RadNumericTextBoxMileage = (RadNumericTextBox)Step5PanelItem.FindControl("RadNumericTextBoxMileage");
        TextBox TextBoxMaterial = (TextBox)Step5PanelItem.FindControl("TextBoxMaterial");
        RadComboBox RadComboBoxTechnician = (RadComboBox)Step5PanelItem.FindControl("RadComboBoxTechnician");
        RadComboBox RadComboBoxAssistant = (RadComboBox)Step5PanelItem.FindControl("RadComboBoxAssistant");
        TextBox TextBoxScopeofExamination = (TextBox)Step5PanelItem.FindControl("TextBoxScopeofExamination");
        RadComboBox RadComboBoxTechLevel = (RadComboBox)Step5PanelItem.FindControl("RadComboBoxTechLevel");
        RadComboBox RadComboBoxAssistLevel = (RadComboBox)Step5PanelItem.FindControl("RadComboBoxAssistLevel");
       
        

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set TotalHours = @TotalHours, Mileage = @Mileage, Material = @Material,TechnicianID = @TechnicianID,AssistantID = @AssistantID,ScopeofExamination = @ScopeofExamination," +
                         " TechnicianLevelID = @TechnicianLevelID, AssistantLevelID = @AssistantLevelID" +
                         " Where CertificationID = @CertificationID ";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@TotalHours", RadNumericTextBoxTotalHours.Text);
        cmd.Parameters.AddWithValue("@Mileage", RadNumericTextBoxMileage.Text);
        cmd.Parameters.AddWithValue("@Material", TextBoxMaterial.Text);
        cmd.Parameters.AddWithValue("@TechnicianID", RadComboBoxTechnician.SelectedValue);
        cmd.Parameters.AddWithValue("@AssistantID", RadComboBoxAssistant.SelectedValue);

        cmd.Parameters.AddWithValue("@TechnicianLevelID", RadComboBoxTechLevel.SelectedValue);
        cmd.Parameters.AddWithValue("@AssistantLevelID", RadComboBoxAssistLevel.SelectedValue);
        cmd.Parameters.AddWithValue("@ScopeofExamination", TextBoxScopeofExamination.Text);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
            GoToNextItem2();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonStep6Next_Click(object sender, EventArgs e)
    {
        RadPanelItem Step6PanelItem = RadPanelBar2.FindItemByValue("Step6PanelItem");        
        RadComboBox RadComboBoxMagPartType = (RadComboBox)Step6PanelItem.FindControl("RadComboBoxMagPartType");
        RadComboBox RadComboBoxMagPartCurrent = (RadComboBox)Step6PanelItem.FindControl("RadComboBoxMagPartCurrent");
        RadNumericTextBox RadNumericTextBoxAmps = (RadNumericTextBox)Step6PanelItem.FindControl("RadNumericTextBoxAmps");
        TextBox TextBoxMethod = (TextBox)Step6PanelItem.FindControl("TextBoxMethod");
        TextBox TextBoxDemag = (TextBox)Step6PanelItem.FindControl("TextBoxDemag");

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set MagneticParticleTypeID = @MagneticParticleTypeID, MagneticParticleCurrentID = @MagneticParticleCurrentID, MagneticParticleAmps = @MagneticParticleAmps," +
                         " MagneticParticleMethod = @MagneticParticleMethod,MagneticParticleDemagnetized = @MagneticParticleDemagnetized" +
                         " Where CertificationID = @CertificationID ";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@MagneticParticleTypeID", RadComboBoxMagPartType.SelectedValue);
        cmd.Parameters.AddWithValue("@MagneticParticleCurrentID", RadComboBoxMagPartCurrent.SelectedValue);
        cmd.Parameters.AddWithValue("@MagneticParticleAmps", RadNumericTextBoxAmps.Text);
        cmd.Parameters.AddWithValue("@MagneticParticleMethod", TextBoxMethod.Text);
        cmd.Parameters.AddWithValue("@MagneticParticleDemagnetized", TextBoxDemag.Text);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
            GoToNextItem2();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }
    }
    protected void RadButtonStep7Next_Click(object sender, EventArgs e)
    {
        RadPanelItem Step7PanelItem = RadPanelBar2.FindItemByValue("Step7PanelItem");

        RadComboBox RadComboBoxLiquidPenType = (RadComboBox)Step7PanelItem.FindControl("RadComboBoxLiquidPenType");
        RadNumericTextBox RadNumericTextBoxPenetrant = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextBoxPenetrant");
        RadNumericTextBox RadNumericTextBoxDeveloper = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextBoxDeveloper");
        RadNumericTextBox RadNumericTextBoxRemover = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextBoxRemover");
        RadNumericTextBox RadNumericTextLiqPenMin = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextLiqPenMin");
        RadNumericTextBox RadNumericTextBoxLiqPenDevMin = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextBoxLiqPenDevMin");
        RadNumericTextBox RadNumericTextBoxLiqPenRemMin = (RadNumericTextBox)Step7PanelItem.FindControl("RadNumericTextBoxLiqPenRemMin"); 
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification" +
                         " set LiquidPenetrantTypeID = @LiquidPenetrantTypeID, LiquidPenetrantPenetrantTime = @LiquidPenetrantPenetrantTime, LiquidPenetrantDeveloperTime = @LiquidPenetrantDeveloperTime," +
                         " LiquidPenetrantRemoverTime = @LiquidPenetrantRemoverTime,LiquidPenetrantPenetrantMinute = @LiquidPenetrantPenetrantMinute, LiquidPenetrantDeveloperMinute = @LiquidPenetrantDeveloperMinute," +
                         " LiquidPenetrantRemoverMinute = @LiquidPenetrantRemoverMinute" +
                         " Where CertificationID = @CertificationID ";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@LiquidPenetrantTypeID", RadComboBoxLiquidPenType.SelectedValue);
        cmd.Parameters.AddWithValue("@LiquidPenetrantPenetrantTime", RadNumericTextBoxPenetrant.Text);
        cmd.Parameters.AddWithValue("@LiquidPenetrantDeveloperTime", RadNumericTextBoxDeveloper.Text);
        cmd.Parameters.AddWithValue("@LiquidPenetrantRemoverTime", RadNumericTextBoxRemover.Text);
        cmd.Parameters.AddWithValue("@LiquidPenetrantPenetrantMinute", RadNumericTextLiqPenMin.Text);
        cmd.Parameters.AddWithValue("@LiquidPenetrantDeveloperMinute", RadNumericTextBoxLiqPenDevMin.Text);
        cmd.Parameters.AddWithValue("@LiquidPenetrantRemoverMinute", RadNumericTextBoxLiqPenRemMin.Text);

        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
            RadTabStrip1.Tabs[2].Enabled = true;
            RadTabStrip1.Tabs[2].Selected = true;
            RadMultiPage1.SelectedIndex = 2;
            
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
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

        string cmdtext = "";
        int counter = 0;

        int orderNumber = GetMaxImageOrderNum(Convert.ToInt32(TextBoxCertID.Text));
        
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand();
     
        foreach (UploadedFile file in RadAsyncUpload2.UploadedFiles)
            {
                byte[] fileData = new byte[file.InputStream.Length];
                file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);
               
                cmdtext += "Insert into tblSTIM_ImageLibrary (BinaryImage,CertificationID,File_Name,File_Description,Uploaded_USERID,Uploaded_Datetime,ImageOrder)" +
                           " values(@BinaryImage" + counter + ",@CertificationID,@File_Name" + counter + ",@File_Description" + counter + ",@Uploaded_USERID,@Uploaded_Datetime,@ImageOrder" + counter + ");";

                // "if exists(select Max(ImageOrder) from tblSTIM_ImageLibrary where CertificationID = @CertificationID)" +

                cmd.Parameters.Add("@BinaryImage" + counter, SqlDbType.Binary, -1);
                cmd.Parameters["@BinaryImage" + counter].Value = fileData;
                cmd.Parameters.AddWithValue("@File_Name" + counter, file.FileName);
                cmd.Parameters.AddWithValue("@File_Description" + counter, file.FileName);
                cmd.Parameters.AddWithValue("@ImageOrder" + counter, orderNumber + 1);
                counter++;
                orderNumber++;
            }
            cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
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
        //Response.Redirect("http://localhost:61705/Intranet/STIM/CertificateofCompliance.aspx");

        //sp_STIM_GetReportName"
        //.Parameters.Refresh
        //.Parameters("@CertTypeID") = Me.CertificationTypeID
        //.Parameters("@MethodofInspectionID") = Me.MethodofInspectionID
    }
    protected void RadButtonGotoPrint_Click(object sender, EventArgs e)
    {
       
        TextBoxwhereClause.Text = String.Format(" where CertificationID = {0} ", TextBoxCertID.Text);
        FormViewPadEyes.DataBind();
        RadTabStrip1.Tabs[3].Enabled = true;
        RadTabStrip1.Tabs[3].Selected = true;
        RadMultiPage1.SelectedIndex = 3;

        RadSlider1.Visible = true;
        RadSlider2.Visible = true;
            
    }

    public void CreateCert()
    {
        //string dbname = ConfigurationManager.AppSettings["ReportLoc"].ToString();
        ////string dbname = "C:\\STIM Mobile Testing\\Data\\SS Observer II Decoder.mdb";
        //string directory = ConfigurationManager.AppSettings["saveDirectory"].ToString();

        //Microsoft.Office.Interop.Access.Application oAccess = new Microsoft.Office.Interop.Access.Application();
        //oAccess.OpenCurrentDatabase(dbname, true);
        //oAccess.Visible = false;

        //var acFormatXLS = "PDF Format (*.pdf)";
        //string id = TextBoxCertID.Text;
        //string param = "tblSTIM_Certification.CertificationID = " + id;

        //string path = directory + "rptSTIM_Padeyes" + id.ToString();

        //try
        //{
        //    oAccess.DoCmd.OpenReport("rptSTIM_Padeyes", Microsoft.Office.Interop.Access.AcView.acViewPreview, null, null, Microsoft.Office.Interop.Access.AcWindowMode.acWindowNormal, " Where tblSTIM_Certification.CertificationID = " + id);
        //    oAccess.DoCmd.OutputTo(Microsoft.Office.Interop.Access.AcOutputObjectType.acOutputReport, "rptSTIM_Padeyes", acFormatXLS, path + ".pdf", false, null, null);
        //    oAccess.DoCmd.Close(Microsoft.Office.Interop.Access.AcObjectType.acReport, path + ".pdf", Microsoft.Office.Interop.Access.AcCloseSave.acSaveNo);
        //}
        //catch (Exception e)
        //{
        //    KillMsACcess("MSACCESS");
        //}
        //finally
        //{
        //    SavePDF(path + ".pdf");
        //}
    }
    public static bool AlreadyImages()
    {
        return true;

    }
    private void KillMsACcess(string processname)
    {
        Process[] aProc = Process.GetProcessesByName(processname);
        if (aProc.Length > 0)
        {
            for (int i = 0; i < aProc.Length; i++)
            {
                aProc[i].Kill();
            }
        }
    }
    public void SavePDF(string fileName)
    {
        string cmdtext = "";
        byte[] fileData;
        FileInfo finfo = new FileInfo(fileName);
        long numBytes = finfo.Length;

        FileStream fStream = new FileStream(fileName, FileMode.Open, FileAccess.Read);
        BinaryReader br = new BinaryReader(fStream);

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand();
        cmdtext += "Insert into tblSTIM_ImageLibrary (BinaryImage,CertificationID,File_Name,File_Description,Uploaded_USERID,Uploaded_Datetime,IsCert)" +
                       " values(@BinaryImage,@CertificationID,@File_Name,@File_Description,@Uploaded_USERID,@Uploaded_Datetime,1);";


        cmd.Parameters.Add("@BinaryImage", SqlDbType.Binary, -1);
        cmd.Parameters["@BinaryImage"].Value = br.ReadBytes(Convert.ToInt32(numBytes));
        cmd.Parameters.AddWithValue("@File_Name", fileName);
        cmd.Parameters.AddWithValue("@File_Description", "CERT");
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        cmd.Parameters.AddWithValue("@Uploaded_USERID", GlobalMethods.GetUserID(login));
        cmd.Parameters.AddWithValue("@Uploaded_Datetime", DateTime.Now);

        Dbconn.Open();
        cmd.CommandText = cmdtext;
        cmd.Connection = Dbconn;
        try
        {
            cmd.ExecuteNonQuery();
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
        catch(Exception ex)
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
    protected void RadPageView4_Load(object sender, EventArgs e)
    {
       
        //string strQuery = "select BinaryImage,File_Name from tblSTIM_ImageLibrary where CertificationID = @CertificationID and Iscert = 1";
        //SqlCommand cmd = new SqlCommand(strQuery);
        //cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        //DataTable dt = GetData(cmd);
        //if (dt != null)
        //{
        //    download(dt);
        //}
    }
    private void download(DataTable dt)
    {
       // Byte[] bytes = (Byte[])dt.Rows[0]["BinaryImage"];
        
        //Response.Clear();
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "inline;filename=myFile.PDF");
        //Response.BinaryWrite(bytes);
       
        //Response.Expires = 0;
        //Response.Flush();
        //Response.Close();
        //Response.End();
    }
    private DataTable GetData(SqlCommand cmd)
    {
        DataTable dt = new DataTable();
        String strConnString = System.Configuration.ConfigurationManager
        .ConnectionStrings["SSIRentConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnString);
        SqlDataAdapter sda = new SqlDataAdapter();
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }
        catch (Exception ex)
        {
            return null;
        }
        finally
        {
            con.Close();
            sda.Dispose();
            con.Dispose();
        }
    }
    protected void RadComboBoxCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox RadComboBoxCustomer = (RadComboBox)sender;
        RadComboBox RadComboBoxTestType = (RadComboBox)RadComboBoxCustomer.Parent.FindControl("RadComboBoxTestType");

        if (RadComboBoxTestType.SelectedValue != "-1")
        {
            SetCertNumInfo(RadComboBoxTestType);
        }

        RadComboBoxTestType.Enabled = true;

        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");
        RadComboBox RadComboBoxUnitNum = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitNum");
        RadComboBox RadComboBoxUnitDesc = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitDesc");
        //SqlDataSource SqlDataSourceUnitNum = (SqlDataSource)step1Panel.FindControl("SqlDataSourceUnitNum");

        //SqlDataSourceUnitNum.SelectCommand = "Select Distinct ItemNumber from tblSTIM_Certification where CustomerID = @CustomerID";
        //SqlDataSourceUnitNum.SelectParameters.Add("@CustomerID", e.Value);


        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        //SqlDataAdapter adapterItemNumber = new SqlDataAdapter("Select Distinct C.ItemNumber, I.[Inventory ID] as InvID from tblSTIM_Certification C inner join tblInventory I on C.ItemNumber= I.Item where CustomerID = @CustomerID Order By C.ItemNumber", conn);
        SqlDataAdapter adapterItemNumber = new SqlDataAdapter("Select Distinct C.ItemNumber from tblSTIM_Certification C where CustomerID = @CustomerID Order By C.ItemNumber", conn);
        SqlDataAdapter adapterItemDesc = new SqlDataAdapter("Select Distinct ItemDescription from tblSTIM_Certification where CustomerID = @CustomerID", conn);
        adapterItemNumber.SelectCommand.Parameters.AddWithValue("@CustomerID", e.Value);
        adapterItemDesc.SelectCommand.Parameters.AddWithValue("@CustomerID", e.Value);

        DataTable dtItemNumber = new DataTable();
        adapterItemNumber.Fill(dtItemNumber);
        DataTable dtItemDesc = new DataTable();
        adapterItemDesc.Fill(dtItemDesc);

        //RadComboBoxUnitNum.DataValueField = "InvID";
        RadComboBoxUnitNum.DataTextField = "ItemNumber";        
        RadComboBoxUnitNum.DataTextField = "ItemNumber";
        RadComboBoxUnitNum.DataSource = dtItemNumber;

        RadComboBoxUnitDesc.DataTextField = "ItemDescription";
        RadComboBoxUnitDesc.DataValueField = "ItemDescription";
        RadComboBoxUnitDesc.DataSource = dtItemDesc;

        RadComboBoxUnitNum.EmptyMessage = "Select a Unit #";
        RadComboBoxUnitNum.AllowCustomText = true;

        RadComboBoxUnitDesc.EmptyMessage = "Select a Description";
        RadComboBoxUnitDesc.AllowCustomText = true;

        //SqlDataSourceUnitNum.DataBind();
        RadComboBoxUnitNum.DataBind();
        RadComboBoxUnitDesc.DataBind();


    }
    protected void RadComboBoxUnitNum_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");//Here need to set Unit Desc
        RadComboBox RadComboBoxCustomer = (RadComboBox)step1Panel.FindControl("RadComboBoxCustomer");
        RadComboBox RadComboBoxUnitNum = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitNum");
        RadioButtonList RadioButtonListInventory = (RadioButtonList)step1Panel.FindControl("RadioButtonListInventory");
        RadComboBox RadComboBoxUnitDesc = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitDesc");
        RadComboBox RadComboBoxInspectMeth = (RadComboBox)step1Panel.FindControl("RadComboBoxInspectMeth");
        RadComboBox RadComboBoxTestType = (RadComboBox)step1Panel.FindControl("RadComboBoxTestType");

        RadComboBox RadComboBoxRecurrence = (RadComboBox)step1Panel.FindControl("RadComboBoxRecurrence");
        RadTextBox RadTextBoxRecurrenceQuantity = (RadTextBox)step1Panel.FindControl("RadTextBoxRecurrenceQuantity");

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "sp_STIM_GetItemDescription @ItemNumber, @CustomerID, @CompanyInventory";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@ItemNumber", RadComboBoxUnitNum.Text);
        cmd.Parameters.AddWithValue("@CustomerID", RadComboBoxCustomer.SelectedValue);

        if (RadioButtonListInventory.SelectedItem.Text == "Supreme")
            cmd.Parameters.AddWithValue("@CompanyInventory", 1);
        else
            cmd.Parameters.AddWithValue("@CompanyInventory", 0);
        
        try
        {
             SqlDataReader dr = cmd.ExecuteReader();
             if (dr.HasRows)
             {
                 dr.Read();
                 RadComboBoxUnitDesc.Text = dr["ItemDescription"].ToString();
                 TextBoxInventoryID.Text = dr["InventoryID"].ToString();
                 //throw new Exception("test");
               
                //string cmdtext2 = "sp_STIM_GetScheduleInformation @ItemNumber, @CustomerID, @MethodofInspectionID,@CertificationTypeId";
                //SqlCommand cmd2 = new SqlCommand(cmdtext2, Dbconn);
                //Dbconn.Open();
                //cmd2.Parameters.AddWithValue("@ItemNumber", RadComboBoxUnitNum.Text);
                //cmd2.Parameters.AddWithValue("@CustomerID", RadComboBoxCustomer.SelectedValue);
                //cmd2.Parameters.AddWithValue("@MethodofInspectionID", RadComboBoxInspectMeth.SelectedValue);
                //cmd2.Parameters.AddWithValue("@CertificationTypeId", RadComboBoxTestType.SelectedValue);

                //try
                //{
                //    SqlDataReader dr2 = cmd2.ExecuteReader();
                //    if (dr2.HasRows)
                //    {
                //        dr2.Read();
                //        if (dr2["SchedulingMessage"] == "")
                //        {
                //            RadComboBoxRecurrence.SelectedValue = dr2["recurrencetype"].ToString();
                //            RadTextBoxRecurrenceQuantity.Text = dr2["RecurrenceQuantity"].ToString();
                //        }
                //        else
                //        {
                //            throw new Exception("Incomplete Schedluing Information");
                //        }
                //    }
                //}
                //catch (Exception exc)
                //{
                //    throw new Exception(exc.Message);
                //}
                //finally
                //{
                //    cmd2.Dispose();
                //    Dbconn.Close();
                //    Dbconn.Dispose();
                //}
             }
        }
        catch (Exception ex)
        {
            //ClientScript.RegisterStartupScript(GetType(), "test", "This is a test Error",true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + ex.Message + "'); ", true);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            cmd.Dispose();
        }

    }

   
  
    protected void RadComboBoxTestType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox RadComboBoxTestType = (RadComboBox)sender;
        
        SetCertNumInfo(sender);
        GetCertDefaultStatus();
        InsertCerNumber(Convert.ToInt32(e.Value));
        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");//Here need to set Unit Desc
        RadComboBox RadComboBoxInspectMeth = (RadComboBox)step1Panel.FindControl("RadComboBoxInspectMeth");
        RadComboBox RadComboBoxSpecNum = (RadComboBox)step1Panel.FindControl("RadComboBoxSpecNum");
        RadPanelItem Step2PanelItem = RadPanelBar1.FindItemByValue("Step2PanelItem");
        RadComboBox RadComboBoxTestingUnit = (RadComboBox)Step2PanelItem.FindControl("RadComboBoxTestingUnit");

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        SqlDataAdapter adapter = new SqlDataAdapter("SELECT TestingMachineID, TestingMachine FROM tblSTIM_TestingMachines WHERE CertificationTypeID = @CertificationTypeID and TestingMachine is not null Order By TestingMachine ", conn);
        adapter.SelectCommand.Parameters.AddWithValue("@CertificationTypeID", e.Value);       

        DataTable dtMachine = new DataTable();
        adapter.Fill(dtMachine);
        
        RadComboBoxTestingUnit.DataValueField = "TestingMachineID";
        RadComboBoxTestingUnit.DataTextField = "TestingMachine";
        RadComboBoxTestingUnit.DataSource = dtMachine;

        RadComboBoxTestingUnit.EmptyMessage = "Select a Testing Unit";
        RadComboBoxTestingUnit.AllowCustomText = true;
        RadComboBoxTestingUnit.DataBind();
        //**************************************************************Inspection method***************************************************************
        SqlDataAdapter adapter2 = new SqlDataAdapter("SELECT tblSTIM_MethodofInspection.MethodofInspectionID,  tblSTIM_MethodofInspection.MethodofInspection, tblSTIM_MethodofInspection.WebUpload FROM tblSTIM_MethodofInspection " +
                                                                                            " INNER JOIN tblSTIM_SchedulingRecurrences ON tblSTIM_SchedulingRecurrences.MethodofInspectionID = tblSTIM_MethodofInspection.MethodofInspectionID " +
                                                                                            " WHERE tblSTIM_SchedulingRecurrences.defaultRecord = 1 and tblSTIM_SchedulingRecurrences.CertificationTypeID = @CertificationTypeID", conn);
        adapter2.SelectCommand.Parameters.AddWithValue("@CertificationTypeID", e.Value);
        dtMachine.Clear();
        adapter2.Fill(dtMachine);

        RadComboBoxInspectMeth.DataValueField = "MethodofInspectionID";
        RadComboBoxInspectMeth.DataTextField = "MethodofInspection";
        RadComboBoxInspectMeth.DataSource = dtMachine;

        RadComboBoxInspectMeth.EmptyMessage = "Select a Meth of Inspec";
        RadComboBoxInspectMeth.AllowCustomText = true;
        RadComboBoxInspectMeth.DataBind();

        //**************************************************************Spec***************************************************************
        SqlDataAdapter adapter3 = new SqlDataAdapter("SELECT SpecificationNumberID, SpecificationNumber from tblSTIM_Certification_SpecificationNumber where CertificationTypeID =  @CertificationTypeID", conn);
        adapter3.SelectCommand.Parameters.AddWithValue("@CertificationTypeID", e.Value);
        dtMachine.Clear();
        adapter3.Fill(dtMachine);

        RadComboBoxSpecNum.DataValueField = "SpecificationNumberID";
        RadComboBoxSpecNum.DataTextField = "SpecificationNumber";
        RadComboBoxSpecNum.DataSource = dtMachine;

        RadComboBoxSpecNum.EmptyMessage = "Select a Spec Num";
        RadComboBoxSpecNum.AllowCustomText = true;
        RadComboBoxSpecNum.DataBind();


    }
    public void InsertCerNumber(int type)
    {
        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");
        RadComboBox RadComboBoxCustomer = (RadComboBox)step1Panel.FindControl("RadComboBoxCustomer");
        RadComboBox RadComboBoxTestType = (RadComboBox)step1Panel.FindControl("RadComboBoxTestType");

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Insert into tblSTIM_Certification (CertificationStatusID,CustomerID,CertificationNumber,CertificationTypeID," +
                         "VendorID,CreateUserID,CreateDateTime)" +
                         " Values(@CertificationStatusID,@CustomerID,@CertificationNumber,@CertificationTypeID," +
                         "@VendorID, @CreateUserID,@CreateDateTime); SELECT SCOPE_IDENTITY()";

        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@CertificationStatusID", TextBoxCertStatusID.Text);
        cmd.Parameters.AddWithValue("@CustomerID", RadComboBoxCustomer.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificationNumber", LabelCertNumber.Text);
        cmd.Parameters.AddWithValue("@CertificationTypeID", type);
        cmd.Parameters.AddWithValue("@VendorID", GlobalMethods.GetSysFlagValue("STIM"));
        cmd.Parameters.AddWithValue("@CreateUserID", GlobalMethods.GetUserID(login));
        cmd.Parameters.AddWithValue("@CreateDateTime", DateTime.Now);
        try
        {
            TextBoxCertID.Text = cmd.ExecuteScalar().ToString();
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
    protected void RadComboBoxRecurrence_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox RadComboBoxRecurrence = (RadComboBox)sender;
        RadComboBoxRecurrence.Items.Add(new RadComboBoxItem("One Time", "1"));
        RadComboBoxRecurrence.Items.Add(new RadComboBoxItem("Recurring", "2"));
        
    }

    //------------------The following code is to set width for ComboBoxes. I may or may not use this code b/c I want to load the Combo boxes on demand...
    protected void RadComboBoxCustomer_DataBound(object sender,EventArgs e)
    {
        var cbox = ((RadComboBox)sender);
        SetRadComboWidth(cbox);
    }
    protected void RadComboBoxTestType_DataBound(object sender, EventArgs e)
    {
        var cbox = ((RadComboBox)sender);
        SetRadComboWidth(cbox);
    }
    protected void RadListViewStep1_PreRender(object sender, EventArgs e)
    {
        //RadListView RadListViewStep1 = (RadListView)sender;
        //foreach (RadListViewInsertItem item in RadListViewStep1.Items[)       
    }
    protected void RadComboBox1_DataBound(object sender, EventArgs e)
    {
        var cbox = ((RadComboBox)sender);
        SetRadComboWidth(cbox);
    }

    public void GetDefaultSchedule()
    {
        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");//Here need to set Unit Desc
        RadComboBox RadComboBoxCustomer = (RadComboBox)step1Panel.FindControl("RadComboBoxCustomer");
        RadComboBox RadComboBoxUnitNum = (RadComboBox)step1Panel.FindControl("RadComboBoxUnitNum");       
        RadComboBox RadComboBoxInspectMeth = (RadComboBox)step1Panel.FindControl("RadComboBoxInspectMeth");
        RadComboBox RadComboBoxTestType = (RadComboBox)step1Panel.FindControl("RadComboBoxTestType");


        string cmdtext2 = "sp_STIM_GetScheduleInformation @ItemNumber, @CustomerID, @MethodofInspectionID,@CertificationTypeId";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        SqlCommand cmd2 = new SqlCommand(cmdtext2, Dbconn);
        Dbconn.Open();
        cmd2.Parameters.AddWithValue("@ItemNumber", RadComboBoxUnitNum.Text);
        cmd2.Parameters.AddWithValue("@CustomerID", RadComboBoxCustomer.SelectedValue);
        cmd2.Parameters.AddWithValue("@MethodofInspectionID", RadComboBoxInspectMeth.SelectedValue);
        cmd2.Parameters.AddWithValue("@CertificationTypeId", RadComboBoxTestType.SelectedValue);

        try
        {
            SqlDataReader dr2 = cmd2.ExecuteReader();
            if (dr2.HasRows)
            {
                dr2.Read();
                if (dr2["SchedulingMessage"] == "")
                {
                    updateSchedule(dr2["recurrencetype"].ToString(), dr2["RecurrenceQuantity"].ToString(), dr2["schedulingrecurrenceuomid"].ToString());
                }
                else
                {
                    throw new Exception(dr2["SchedulingMessage"].ToString());
                }
            }
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('" + exc.Message + "'); ", true);
        }
        finally
        {
            cmd2.Dispose();
            Dbconn.Close();
            Dbconn.Dispose();
        }
    }

    public void updateSchedule(string recType,string recQuantity, string UOM)
    {
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Update tblSTIM_Certification " +
                         "Set RecurrenceQuantity = @RecurrenceQuantity,RecurrenceType = @RecurrenceType,SchedulingRecurrenceUOMID = @SchedulingRecurrenceUOMID " +
                         "Where CertificationID = @CertificationID";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        cmd.Parameters.AddWithValue("@RecurrenceQuantity", recType);
        cmd.Parameters.AddWithValue("@RecurrenceType", recQuantity);
        cmd.Parameters.AddWithValue("@SchedulingRecurrenceUOMID", UOM);
        cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
        try
        {
            cmd.ExecuteNonQuery();
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
    public void GetVendorID()
    {

    }
    private void GoToNextItem()
    {
        int selectedIndex = RadPanelBar1.SelectedItem.Index;
        RadPanelBar1.Items[selectedIndex + 1].Selected = true;
        RadPanelBar1.Items[selectedIndex + 1].Expanded = true;
        RadPanelBar1.Items[selectedIndex + 1].Enabled = true;
        RadPanelBar1.Items[selectedIndex].Expanded = false;

    }
    private void GoToNextItem2()
    {
        int selectedIndex = RadPanelBar2.SelectedItem.Index;
        RadPanelBar2.Items[selectedIndex + 1].Selected = true;
        RadPanelBar2.Items[selectedIndex + 1].Expanded = true;
        RadPanelBar2.Items[selectedIndex + 1].Enabled = true;
        RadPanelBar2.Items[selectedIndex].Expanded = false;

    }
    public void SetCertNumInfo(object sender)
    {
        RadComboBox RadComboBoxTestType = (RadComboBox)sender;
        RadComboBox RadComboBoxCustomer = (RadComboBox)RadComboBoxTestType.Parent.FindControl("RadComboBoxCustomer");

        RadPanelItem step1Panel = RadPanelBar1.FindItemByValue("Step1PanelItem1");
        Panel InfoPanel = step1Panel.FindControl("PanelInfo") as Panel;

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "sp_STIM_GetNextCertNumber @CustomerID, @CertificationTypeID";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.AddWithValue("@CustomerID", RadComboBoxCustomer.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificationTypeID", RadComboBoxTestType.SelectedValue);
        Dbconn.Open();
        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                if (dr["certmessage"].ToString() == "")
                {
                    LabelCertNum.Visible = true;
                    LabelCertNum.Text += " " + dr["certnumber"].ToString();
                    //LabelCertNumber.Visible = true;
                    LabelCertStatus.Visible = true;
                    LabelCertNumber.Text = dr["certnumber"].ToString();
                    InfoPanel.Visible = true;
                }
                else
                    LabelCustomerError.Text = dr["certmessage"].ToString();

            }
        }
        catch (Exception ex) { LabelCustomerError.Text = ex.Message; }
        finally 
        { 
            Dbconn.Close(); 
            Dbconn.Dispose(); 
            cmd.Dispose(); 
            RadComboBoxTestType.Items.Clear(); 
            RadComboBoxTestType.DataBind(); 
            //RadComboBoxCustomer.Items.Clear(); 
            //RadComboBoxCustomer.DataBind(); 
        }
    }
    public void GetCertDefaultStatus()
    {

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
        string cmdtext = "Select CertificationStatusID, ObjectStatus from tblSTIM_CertificationStatus where ObjectStatusCode = 'Onsite'";

        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        Dbconn.Open();
        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                //LabelCertificateStatus.Visible = true;
                //LabelCertificateStatus.Text = dr["ObjectStatus"].ToString();
                LabelCertStatus.Text += " " + dr["ObjectStatus"].ToString();
                TextBoxCertStatusID.Text = dr["CertificationStatusID"].ToString();
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
        //strrowsource = "SELECT TestingMachineID, TestingMachine FROM tblSTIM_TestingMachines WHERE CertificationTypeID = " & CertificationTypeID
        //Me!TestingMachineID.RowSource = strrowsource
        //strrowsource = "SELECT SpecificationNumberID, SpecificationNumber from tblSTIM_Certification_SpecificationNumber where CertificationTypeID = " & Me.CertificationTypeID
        //Me.SpecificationNumberID.RowSource = strrowsource
    }
    public static void SetRadComboWidth(RadComboBox cbox)
    {
        int MaxWidth = 155;
        foreach (RadComboBoxItem item in cbox.Items)
        {
            int Width = TextWidth(item.Text);
            if (Width > MaxWidth)
            {
                MaxWidth = Width;                
            }
        }
        cbox.DropDownWidth = new Unit(MaxWidth);
    }
    public static int TextWidth(String TheText)
    {
        Font DrawFont = null;
        Graphics DrawGraphics = null;
        Bitmap TextBitmap = null;
        try
        {
            TextBitmap = new Bitmap(1, 1);
            DrawGraphics = Graphics.FromImage(TextBitmap);
            DrawFont = new Font("Segoe UI", 12);

            int Width = (int)DrawGraphics.MeasureString(TheText, DrawFont).Width;

            return Width;
        }
        finally
        {
            TextBitmap.Dispose();
            DrawFont.Dispose();
            DrawGraphics.Dispose();
        }
    } 

     //UploadedFile file = RadAsyncUpload2.UploadedFiles[0];
     //   byte[] fileData = new byte[file.InputStream.Length];
     //   file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);

     //   SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
     //   string cmdtext = "Insert into tblSTIM_ImageLibrary (BinaryImage,CertificationID,File_Name,File_Description,Uploaded_USERID,Uploaded_Datetime)" +
     //                    " values(@BinaryImage,@CertificationID,@File_Name,@File_Description,@Uploaded_USERID,@Uploaded_Datetime)";

     //   SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
     //   Dbconn.Open();
     //   cmd.Parameters.Add("@BinaryImage", SqlDbType.Binary, -1);
     //   cmd.Parameters["@BinaryImage"].Value = fileData;

     //   cmd.Parameters.AddWithValue("@CertificationID", TextBoxCertID.Text);
     //   //cmd.Parameters.AddWithValue("@File_Name", RadComboBoxLiquidPenType.SelectedValue);
     //   //cmd.Parameters.AddWithValue("@File_Description", RadComboBoxLiquidPenType.SelectedValue);
     //   //cmd.Parameters.AddWithValue("@Uploaded_USERID", RadComboBoxLiquidPenType.SelectedValue);
     //   //cmd.Parameters.AddWithValue("@Uploaded_Datetime",DateTime.Now);


    
      
}
