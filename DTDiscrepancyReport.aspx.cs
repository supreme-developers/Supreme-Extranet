using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DTDiscrepancyReport : System.Web.UI.Page
{
    int fixheaderonce = 0;
    string currentDiscrepType = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {


        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Literal DT = (Literal)repeater1.Controls[0].Controls[0].FindControl("DT");
            Literal InvoiceNumber = (Literal)repeater1.Controls[0].Controls[0].FindControl("InvoiceNumber");
            Literal Quote = (Literal)repeater1.Controls[0].Controls[0].FindControl("Quote");
            Literal JobType = (Literal)repeater1.Controls[0].Controls[0].FindControl("JobType");

            dynamic dataitem = e.Item.DataItem as dynamic;
            DTDiscrepancy d = (DTDiscrepancy)dataitem;

            if (fixheaderonce == 0) //don't need to run this code evertime hence the variable fixheaderonce
            {
                DT.Text = d.DTNumber;
                InvoiceNumber.Text = d.InvoiceNumber;
                Quote.Text = d.QuoteNumber;
                fixheaderonce = 2;

            }
            Literal DiscrType = (Literal)e.Item.FindControl("DiscrepancyType");

            if (d.DiscrepancyType != currentDiscrepType)
            {
                DiscrType.Text = d.DiscrepancyType;
                currentDiscrepType = d.DiscrepancyType;
            }
        }

    }
}