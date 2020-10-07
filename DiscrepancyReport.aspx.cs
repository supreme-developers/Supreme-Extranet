using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DiscrepancyReport : System.Web.UI.Page
{
    int fixheaderonce = 0;
    string currentPrintType = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {


        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Literal Quote = (Literal)repeater1.Controls[0].Controls[0].FindControl("Quote");
            Literal QDate = (Literal)repeater1.Controls[0].Controls[0].FindControl("QDate");
            Literal Customer = (Literal)repeater1.Controls[0].Controls[0].FindControl("Customer");
            Literal JobType = (Literal)repeater1.Controls[0].Controls[0].FindControl("JobType");           

            dynamic dataitem = e.Item.DataItem as dynamic;
            QuoteDiscrepancy q = (QuoteDiscrepancy)dataitem;

            if (fixheaderonce == 0) //don't need to run this code evertime hence the variable fixheaderonce
            {
                Quote.Text = q.QuoteNumber;
                QDate.Text = q.QuoteDate;
                Customer.Text = q.Customer;
                JobType.Text = q.JobType;               
                fixheaderonce = 2;

            }
        }

    }

}