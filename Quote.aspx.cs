using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Data.SqlClient;
using Telerik.Web.UI;


public partial class Quote : System.Web.UI.Page
{
    double? min = 0;
    double? addday = 0;
    double? finalMin = 0;
    double? finalAddDay = 0;
    int fixheaderonce = 0;
    string currentPrintType = "";
    int QHeaderId = 0;
    int UserID;
    int CreateUserID;
    int? EstDays;
    double? EstDaysRental;
    string QuoteStatus = "";
    Boolean CalculateEstimatedDays;
    Boolean HasDiscrepancyReport;
    QuoteRepository quote = new QuoteRepository();
    protected void Page_Load(object sender, EventArgs e)
    {
        SetVariables();
    }

    //private QuotePresenter BuildPresenter()
    //{
    //    Quote quote = new Quote();
    //    return new QuotePresenter()
    //}

    protected void Button1_Click(object sender, EventArgs e)
    {
        //ShowReport();
    }
    private void ShowReport()
    {
        //try
        //{
        //    SSIReportEngine.SSIReportGeneratorWrapper rpt = new SSIReportEngine.SSIReportGeneratorWrapper();

        //    string urlReportServer = ConfigurationManager.AppSettings["ReportURL"];
        //    ReportViewer1.ProcessingMode = ProcessingMode.Remote; // ProcessingMode will be Either Remote or Local
        //    ReportViewer1.ServerReport.ReportServerUrl = new Uri(urlReportServer); //Set the ReportServer Url
        //    ReportViewer1.ServerReport.ReportPath = ConfigurationManager.AppSettings["ReportPath"] + "rptWOR_PartsOrder_RequisitionItems";

        //    Guid guid;
        //    ReportParameter REQID = new ReportParameter("REQID", "83");
        //    ReportParameter StatusCode = new ReportParameter("StatusCode", "");
        //    rpt.AddParameter("REQID", 83);
        //    rpt.AddParameter("StatusCode", null);

        //    guid = rpt.GenerateReport();
        //    rpt.AddParameter("GUID", guid.ToString());

        //    ReportParameter rp = new ReportParameter("GUID", guid.ToString());
        //    ReportViewer1.ServerReport.SetParameters(new ReportParameter[] {rp});
        //    //ReportViewer1.ServerReport.SetParameters(new ReportParameter[] {REQID});
        //    //ReportViewer1.ServerReport.SetParameters(new ReportParameter[] {StatusCode});

          
        //    ReportViewer1.DataBind();

    

        //   // Guid guid = GlobalMethods.RetrieveGUID();
                

        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }


    protected void QuoteObjectDataSource_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
    {
        //var presenter = this.BuildPresenter();
        //e.ObjectInstance = presenter;
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
      

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Literal dispatcher = (Literal)repeater1.Controls[0].Controls[0].FindControl("dispatcher");
            Literal invoiceTo = (Literal)repeater1.Controls[0].Controls[0].FindControl("invoiceTo");
            Literal orderedby = (Literal)repeater1.Controls[0].Controls[0].FindControl("orderedby");
            Literal ponumber = (Literal)repeater1.Controls[0].Controls[0].FindControl("ponumber");
            Literal jobnumber = (Literal)repeater1.Controls[0].Controls[0].FindControl("jobnumber");
            Literal ordernumber = (Literal)repeater1.Controls[0].Controls[0].FindControl("ordernumber");
            Literal shipvia = (Literal)repeater1.Controls[0].Controls[0].FindControl("shipvia");
            Literal shipto = (Literal)repeater1.Controls[0].Controls[0].FindControl("shipto");
            Literal lease = (Literal)repeater1.Controls[0].Controls[0].FindControl("lease");

            Literal date = (Literal)repeater1.Controls[0].Controls[0].FindControl("date");
           // Literal status = (Literal)repeater1.Controls[0].Controls[0].FindControl("status");
            Literal afe = (Literal)repeater1.Controls[0].Controls[0].FindControl("afe");
            Literal area = (Literal)repeater1.Controls[0].Controls[0].FindControl("area");
            Literal rig = (Literal)repeater1.Controls[0].Controls[0].FindControl("rig");
            Literal well = (Literal)repeater1.Controls[0].Controls[0].FindControl("well");
            Literal state = (Literal)repeater1.Controls[0].Controls[0].FindControl("state");
            Literal parish = (Literal)repeater1.Controls[0].Controls[0].FindControl("parish");
            Literal jobtype = (Literal)repeater1.Controls[0].Controls[0].FindControl("jobtype");
            Literal contractor = (Literal)repeater1.Controls[0].Controls[0].FindControl("contractor");
            Literal priceStrategy = (Literal)repeater1.Controls[0].Controls[0].FindControl("priceStrategy");
            Literal alternateJobType = (Literal)repeater1.Controls[0].Controls[0].FindControl("ajobtype");
            Literal ajobtypeTitle = (Literal)repeater1.Controls[0].Controls[0].FindControl("ajobtypeTitle");            
            Label QuoteNum = (Label)repeater1.Controls[0].Controls[0].FindControl("LabelQuoteNumber");
            Label Revision = (Label)repeater1.Controls[0].Controls[0].FindControl("LabelRevision");
            Label LabelStatus = (Label)repeater1.Controls[0].Controls[0].FindControl("LabelStatus");
            Literal Salesmen = (Literal)repeater1.Controls[0].Controls[0].FindControl("Salesmen");
            dynamic dataitem = e.Item.DataItem as dynamic;
                QuoteObject q = (QuoteObject)dataitem;

            if (fixheaderonce == 0) //don't need to run this code evertime hence the variable fixheaderonce
            {
                dispatcher.Text = q.Dispatcher;
                invoiceTo.Text = q.InvoiceTo;
                orderedby.Text = q.OrderedBy;
                ponumber.Text = q.PONumber;
                jobnumber.Text = q.JobNumber;
                ordernumber.Text = q.OrderNumber;
                shipvia.Text = q.ShipVia;
                shipto.Text = q.ShipTo;
                lease.Text = q.Lease;

                date.Text = q.Date;
               // status..Text = q.Status;
                afe.Text = q.AFE;
                area.Text = q.Area;
                rig.Text = q.RigNum;
                well.Text = q.WellNum;
                state.Text = q.State;
                parish.Text = q.Parish;
                jobtype.Text = q.JobType;
                contractor.Text = q.Contractor;
                Salesmen.Text = q.Salesmen.TrimEnd(',');


                if (q.QuotePriceBook == 1)
                    priceStrategy.Text = "Supreme Book Pricing";

                if (q.QuotePriceBook == 2)
                    priceStrategy.Text = "Customer Pricing";

                if (q.QuotePriceBook == 3)
                {
                    alternateJobType.Text = q.AlternateJobType;
                    ajobtypeTitle.Text = "Alternate Job Type:";
                    priceStrategy.Text = "Alternate Customer - " + q.AlternateCustomerNumber;
                }

                QuoteNum.Text = q.Number;
                Revision.Text = q.Revision;
                CreateUserID = q.CreateUserID;
                QuoteStatus = q.Status;
                HasDiscrepancyReport = q.HasDiscrepancyReport;
                EstDays = q.EstimatedDays;
                EstDaysRental = q.EstimatedDaysRental;
                CalculateEstimatedDays = q.CalculateEstimatedDays;
                LabelStatus.Text = q.Status;
                fixheaderonce = 2;

                CheckBox hCheckBox1 = (CheckBox)repeater1.Controls[0].Controls[0].FindControl("CheckBox1");

                Panel PanelDiscrep = (Panel)repeater1.Controls[0].Controls[0].FindControl("PanelDiscrep");

                if (q.HasDiscrepancyReport)
                {
                    PanelDiscrep.Visible = true;                   
                }

            }

            Literal PrintType = (Literal)e.Item.FindControl("PrintType");

            if (q.Type != currentPrintType)
            {
                
                PrintType.Text = q.Type;

                if (currentPrintType != "")
                {
                    //Get Previous Items Controls
                    int pIndex = e.Item.ItemIndex - 1;
                    RepeaterItem previousItem = (RepeaterItem)repeater1.Items[pIndex];
                    Panel PanelTotals = (Panel)previousItem.FindControl("PanelTotals");
                   

                    Literal TypeTotal = (Literal)previousItem.FindControl("LiteralTypeTotal");
                    Literal MinTotal = (Literal)previousItem.FindControl("MinTotal");
                    Literal AddDayTotal = (Literal)previousItem.FindControl("AddDayTotal");

                    PanelTotals.Visible = true;
                    TypeTotal.Text = currentPrintType + " Total:";
                    MinTotal.Text =  string.Format("{0:C}", min);
                    AddDayTotal.Text = string.Format("{0:C}", addday);

                    finalMin += min;
                    finalAddDay += addday;

                    min = 0;
                    addday = 0;
                }
             
                min = min + q.NetMin;
                addday = addday + q.NetAddDay;

                currentPrintType = q.Type;
            }
            else
            {
                min = min + q.NetMin;
                addday = addday + q.NetAddDay;

                PrintType.Visible = false;
            }

        }

        if (e.Item.ItemType == ListItemType.Footer)
        {

            //-----------------------------------Final SubTotal--------------------------------

            int pindex = repeater1.Items.Count - 1;

            RepeaterItem LastItem = (RepeaterItem)repeater1.Items[pindex];
            Panel PanelTotals = (Panel)LastItem.FindControl("PanelTotals");

            //CheckBox CheckBox1 = (CheckBox)LastItem.FindControl("CheckBox1");
            CheckBox CheckBox1 = (CheckBox)repeater1.Controls[repeater1.Controls.Count - 1].Controls[0].FindControl("CheckBox1");
            Literal TypeTotal = (Literal)LastItem.FindControl("LiteralTypeTotal");
            Literal MinTotal = (Literal)LastItem.FindControl("MinTotal");
            Literal AddDayTotal = (Literal)LastItem.FindControl("AddDayTotal");

            PanelTotals.Visible = true;
            TypeTotal.Text = currentPrintType + " Total:";
            MinTotal.Text = string.Format("{0:C}", min);
            AddDayTotal.Text = string.Format("{0:C}", addday);

            finalMin += min;
            finalAddDay += addday;

           
           ((Label)e.Item.FindControl("LabelTotalMin")).Text = string.Format("{0:C}", finalMin);
           ((Label)e.Item.FindControl("LabelTotalAddDay")).Text = string.Format("{0:C}", finalAddDay);
            Panel PanelButtons = (Panel)e.Item.FindControl("PanelButtons");
            Panel PanelDiscrep = (Panel)e.Item.FindControl("PanelDiscrep");
            Panel PanelEstDays = (Panel)e.Item.FindControl("PanelEstDays");
            if (CreateUserID != Convert.ToInt32(Session["UserID"]) && HasDiscrepancyReport)
            {
                //Don'te show Approve / Reject buttons yet until after discrep acknowledgement has been made
                PanelDiscrep.Visible = true;
                if (QuoteStatus != "Pending Approval")
                    CheckBox1.Visible = false;

            }
            else
            {
                if (CreateUserID != Convert.ToInt32(Session["UserID"]) && QuoteStatus == "Pending Approval")
                {
                    PanelButtons.Visible = true;

                    if (Session["DisAck"] != null)
                    {
                        PanelDiscrep.Visible = true;
                        CheckBox1.Enabled = false;
                    }
                }
            }
           
            if (CalculateEstimatedDays)
            {
                PanelEstDays.Visible = true;
                ((Label)e.Item.FindControl("LabelEstDays")).Text = EstDays.ToString();
                ((Label)e.Item.FindControl("LabelDaysRental")).Text = string.Format("{0:C}", EstDaysRental);
            }


            min = 0;
            addday = 0;

           
        }

       

    }

    protected void SubmitReject_Click(object sender, EventArgs e)
    {
        SetVariables();
        string error = "";
        TextBox TextBoxReason = (TextBox)repeater1.Controls[repeater1.Controls.Count - 1].Controls[0].FindControl("TextBoxReason");

        if (TextBoxReason.Text == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "key", "alert('You must enter a reason before Rejecting!') ", true);

        }
        else
        {
            error = this.quote.ApproveReject(QHeaderId, UserID, TextBoxReason.Text, "Reject");

            repeater1.Visible = false;
            PanelMessage.Visible = true;
          
            if (error == "")
                LabelMessage.Text = "<p class='text-center text-success fa-2x' >Quote Successfully Denied!</p>";
            else
                LabelMessage.Text = "<p class='text-center text-danger fa-2x' >" + error + "</p>";
        }

    }
    protected void Approve_Click(object sender, EventArgs e)
    {
        SetVariables();
        string error = "";
        TextBox TextBoxReason = (TextBox)repeater1.Controls[repeater1.Controls.Count - 1].Controls[0].FindControl("TextBoxReason");
        error = this.quote.ApproveReject(QHeaderId, UserID, TextBoxReason.Text, "Approve");
        repeater1.Visible = false;
        PanelMessage.Visible = true;

        if (error == "")
            LabelMessage.Text = "<p class='text-center text-success fa-2x' >Quote Successfully Approved!</p>";
        else
            LabelMessage.Text = "<p class='text-center text-danger fa-2x' >" + error + "</p>"; 

    }

    private void SetVariables()
    {
        
        QHeaderId = Convert.ToInt32(Request.QueryString["QHeaderID"]);
        Session["QHeaderId"] = QHeaderId;
        UserID = Convert.ToInt32(Session["UserID"]);
        
    }

  

    protected void repeater1_Unload(object sender, EventArgs e)
    {
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        
        CheckBox me = (CheckBox)sender;
        Panel PanelButtons = (Panel)repeater1.Controls[repeater1.Controls.Count - 1].Controls[0].FindControl("PanelButtons");
        me.Enabled = false;
       // this.quote.DiscrepancyAcknowledgement(Convert.ToInt32(Request.QueryString["QHeaderID"]), Convert.ToInt32(Session["UserID"]));
        PanelButtons.Visible = true;


    }
}