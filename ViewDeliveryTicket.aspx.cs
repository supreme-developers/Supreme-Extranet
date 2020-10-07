using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewDeliveryTicket : System.Web.UI.Page
{
    int fixheaderonce = 0;
    Boolean HasDiscrepancy;
    protected void Page_Load(object sender, EventArgs e)
    {

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
            Label LabelDTNumber = (Label)repeater1.Controls[0].Controls[0].FindControl("LabelDTNumber");
            // Label LabelStatus = (Label)repeater1.Controls[0].Controls[0].FindControl("LabelStatus");
         
            dynamic dataitem = e.Item.DataItem as dynamic;
            DeliveryTicket d = (DeliveryTicket)dataitem;

            if (fixheaderonce == 0) //don't need to run this code evertime hence the variable fixheaderonce
            {
                dispatcher.Text = d.Dispatcher;
                invoiceTo.Text = d.InvoiceTo;
                orderedby.Text = d.OrderedBy;
                ponumber.Text = d.PONumber;
                jobnumber.Text = d.JobNumber;
                ordernumber.Text = d.OrderNumber;
                shipvia.Text = d.ShipVia;
                shipto.Text = d.ShipTo;
                lease.Text = d.Lease;

                date.Text = d.DeliveryDate;
                state.Text = d.State;
                afe.Text = d.AFE;
                area.Text = d.Area;
                rig.Text = d.RigNum;
                well.Text = d.WellNum;
                state.Text = d.State;
                parish.Text = d.Parish;
                jobtype.Text = d.JobType;
                contractor.Text = d.Contractor;

                if (d.QuotePriceBook == 1)
                    priceStrategy.Text = "Supreme Book Pricing";

                if (d.QuotePriceBook == 2)
                    priceStrategy.Text = "Customer Pricing";

                if (d.QuotePriceBook == 3)
                {
                    alternateJobType.Text = d.AlternateJobType;
                    ajobtypeTitle.Text = "Alternate Job Type:";
                    priceStrategy.Text = "Alternate Customer - " + d.AlternateCustomerNumber;
                }


                LabelDTNumber.Text = d.DTNumber;
                //CreateUserID = d.CreateUserID;
                //QuoteStatus = d.Status;
                HasDiscrepancy= d.HasDisrepancy;
                fixheaderonce++;

                CheckBox hCheckBox1 = (CheckBox)repeater1.Controls[0].Controls[0].FindControl("CheckBox1");

                Panel PanelDiscrep = (Panel)repeater1.Controls[0].Controls[0].FindControl("PanelDiscrep");

                if (HasDiscrepancy)
                {
                    PanelDiscrep.Visible = true;
                }
            }


        }
        if (e.Item.ItemType == ListItemType.Footer)
            {
            Panel PanelDiscrep = (Panel)e.Item.FindControl("PanelDiscrep");
            if (HasDiscrepancy)
                {
                    //Don'te show Approve / Reject buttons yet until after discrep acknowledgement has been made
                    PanelDiscrep.Visible = true;
                }
                else
                {
                    if (Session["DisAck"] != null)
                    {
                        PanelDiscrep.Visible = true;
                        // CheckBox1.Enabled = false;
                    }
                }
            }
        
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox me = (CheckBox)sender;
      //  Panel PanelButtons = (Panel)repeater1.Controls[repeater1.Controls.Count - 1].Controls[0].FindControl("PanelButtons");
        me.Enabled = false;
        // this.quote.DiscrepancyAcknowledgement(Convert.ToInt32(Request.QueryString["QHeaderID"]), Convert.ToInt32(Session["UserID"]));
      //  PanelButtons.Visible = true;


    }
}