<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MainMaster.master" AutoEventWireup="true" CodeFile="Quote.aspx.cs" Inherits="Quote" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" Runat="Server">
    <style>
        .borderless td, .borderless th 
        {
             border: none !important;
        }
    </style>
       <div class="row">
            <div class="col-lg-12">
                <div class="col-lg-2"> 
                    <a href="Login.aspx">
                    <img src="Graphics/SupremeServices_WebApps.png" />
                    </a>
                </div>
                <div class="col-lg-8">
                         
                </div>
                <div class="col-lg-2"> </div>
            </div>
        </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" SkinID="MetroTouch" ClientEvents-OnResponseEnd="CreateScripts" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="repeater1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="repeater1" LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PanelMessage" LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="SubmitReject">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMessage" LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="MetroTouch">
    </telerik:RadAjaxLoadingPanel>
   <div class="container-fluid">
        <div class="row">
            <div class="well col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
                 <asp:Panel ID="PanelMessage" runat="server" Visible="False">
                        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
                    
                </asp:Panel>
                 <asp:Repeater ID="repeater1" runat="server" DataSourceID="QuoteObjectDataSource" OnItemDataBound="Repeater1_ItemDataBound"
                      OnUnload="repeater1_Unload">
                  <HeaderTemplate>
                        <div class="row">
                             <asp:Panel ID="PanelDiscrep" runat="server" Visible="false">
                           <div class="row">
                                <div colspan="6" align="center" class="text-danger fa-3x">
                                    <span class="glyphicon glyphicon-exclamation-sign ">  </span>
                                    This Quote has a Discrepancy Report!
                                </div>
                          </div> 
                             <div class="row">
                                <div colspan="6" align="center" >
                                   <a class="btn btn-danger btn-lg" href="DiscrepancyReport.aspx?QHeaderID=<%# Convert.ToInt32(Request.QueryString["QHeaderID"]) %>"  >
                                            <span class="glyphicon glyphicon-list-alt"></span> View Report 
                                    </a>
                               </div>
                           </div>
                         
                               
                        </asp:Panel> 
                        <div class="col-xs-6 col-sm-6 col-md-6 text-left">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Dispatcher:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="dispatcher" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Invoice To:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="invoiceTo" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Ordered By:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="orderedby" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>PO Number:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="ponumber" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Job Number:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="jobnumber" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Order Number:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="ordernumber" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Ship Via:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="shipvia" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Ship To:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="shipto" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Lease / Ocsg:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="lease" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Salesmen:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="Salesmen" runat="server"></asp:Literal><em></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 text-right">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Date:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="date" runat="server"></asp:Literal><em><em></td>
                                </tr>
                               <%--  <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Status:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="status" runat="server">Pending Post</asp:Literal><em></td>
                                </tr>--%>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>AFE #:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="afe" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Area/Block #:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="area" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Rig #:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="rig" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Well #:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="well" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>State:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="state" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Parish:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="parish" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Job Type:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="jobtype" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Contractor:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="contractor" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-danger"><strong>Price Strategy:</strong></td>
                                    <td class="text-left text-danger"><em><asp:Literal ID="priceStrategy" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong><asp:Literal ID="ajobtypeTitle" runat="server"></asp:Literal></strong></td>
                                    <td class="text-left"><em><asp:Literal ID="ajobtype" runat="server"></asp:Literal><em></td>
                                </tr>
                                
                            </table>
                        </div>
                       
                
                    </div>
                    <div class="row">
                            <div class="text-center">
                                <h1>Quote #:<asp:Label ID="LabelQuoteNumber" runat="server" Text=""></asp:Label> (<asp:Label ID="LabelRevision" Font-Italic="true" runat="server" Text=""></asp:Label>)</h1>
                                <h4>Status: <i><asp:Label ID="LabelStatus" runat="server" Text=""></asp:Label></i> </h4>
                            </div>
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th>Quantity</th>
                                        <th>Item Descr</th>                                        
                                        <th class="text-center">Min. Rental Days</th>
                                        <th class="text-center">Min.</th>
                                        <th class="text-center">Add. Day</th>
                                        <th>Disc Rate</th>
                                    </tr>
                                </thead>
                  </HeaderTemplate>
                  <ItemTemplate>
                         <tr ><td colspan="6" class="col-md-12 text-center text-capitalize text-info" style="border:None">
                             <h4>  <strong><i><asp:Literal ID="PrintType" runat="server"></asp:Literal></i> </strong></h4> </td></tr>
                          <tr >
                               <td class="col-md-1" style="text-align: center"> <%# Eval("Quantity") %> </td>
                                <td class="col-md-8"><em><%# Eval("ItemDescription") %></em></h4></td>                               
                                <td class="col-md-1 text-center"><%# Eval("MinRentalDays") %></td>
                                <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "NetMin"))%></td>
                                <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "NetAddDay")) %></td>
                               <td class="col-md-1 text-center"><%# Eval("DiscountRate") %></td>
                          </tr>
                          <asp:Panel ID="PanelTotals" runat="server" Visible="false">
                              <tr>
                                  <td></td>
                                  
                                  <td class="text-right fa-1x" colspan="2">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="LiteralTypeTotal" runat="server"></asp:Literal>
                                          </strong>
                                      </p>

                                  </td>
                                  <td class="text-center fa-1x">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="MinTotal" runat="server"></asp:Literal></strong>
                                      </p>
                                  </td>
                                  <td class="text-center fa-1x">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="AddDayTotal" runat="server"></asp:Literal></strong>
                                      </p>
                                  </td>
                              </tr>
                          </asp:Panel>

                     
                  </ItemTemplate>
                  <FooterTemplate>
                        <asp:Panel ID="PanelTotals" runat="server" Visible="false">
                              <tr>
                                  <td></td>
                                  
                                  <td class="text-right fa-1x" colspan="2">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="LiteralTypeTotal" runat="server"></asp:Literal>
                                          </strong>
                                      </p>

                                  </td>
                                  <td class="text-center fa-1x">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="MinTotal" runat="server"></asp:Literal></strong>
                                      </p>
                                  </td>
                                  <td class="text-center fa-1x">
                                      <p>
                                          <strong>
                                              <asp:Literal ID="AddDayTotal" runat="server"></asp:Literal></strong>
                                      </p>
                                  </td>
                              </tr>
                          </asp:Panel>
                                <tr>
                                    <td></td>
                                    <td colspan="2" class="text-right">
                                        <h4><strong>Quote Totals: </strong></h4>
                                    </td>
                                    <td class="text-center text-success">
                                        <h4><strong><asp:Label ID="LabelTotalMin" runat="server" Text=""></asp:Label></strong></h4>
                                    </td>
                                    <td class="text-center text-success">
                                        <h4><strong><asp:Label ID="LabelTotalAddDay" runat="server" Text=""></asp:Label></strong></h4>
                                    </td>
                                    <td></td>
                                </tr>
                      <asp:Panel ID="PanelEstDays" runat="server" Visible="false">
                             <br />
                                <tr>
                                    <td colspan="2"  class="text-right "><strong>Estimated Days: <asp:Label ID="LabelEstDays" runat="server" Text="" CssClass="text-info"></asp:Label></strong></td>
                                     <td colspan="2" class="text-right"><strong>Estimated Days Rental:</strong> </td>
                                    <td colspan="2"><strong><asp:Label ID="LabelDaysRental" runat="server" Text="" CssClass="text-info"></asp:Label></strong></td>
                                </tr>
                    </asp:Panel>
                       <asp:Panel ID="PanelDiscrep" runat="server" Visible="false">
                            <tr>
                                <td colspan="6" align="center" class="text-danger fa-3x">
                                    <span class="glyphicon glyphicon-exclamation-sign ">  </span>
                                    This Quote has a Discrepancy Report!
                                </td>
                            </tr>
                            <tr>
                               <td colspan="6" align="center" >
                                   <a class="btn btn-danger btn-lg" href="DiscrepancyReport.aspx?QHeaderID=<%# Convert.ToInt32(Request.QueryString["QHeaderID"]) %>"  >
                                            <span class="glyphicon glyphicon-list-alt"></span> View Report 
                                    </a>

                               </td>
                           </tr>
                           <tr>
                               <td colspan="6" align="center" >
                                   <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" Font-Size="X-Large" style="cursor:pointer; padding:5px"
                                        OnCheckedChanged="CheckBox1_CheckedChanged" Text="&nbsp;I acknowledge that I read the Discrepency Report! " /> 
                               </td>
                           </tr>
                               
                        </asp:Panel>
                      <asp:Panel ID="PanelButtons" runat="server" Visible="false">
                                <tr>
                                   
                                    <td colspan="6" align="center">
                                       <%-- <button type="button" class="btn btn-danger btn-lg reject" >
                                            Reject  <span class="glyphicon glyphicon-remove"></span>
                                        </button>--%>
                                         <button id="Reject" runat="server" type="button" class=" btn btn-danger btn-lg btn-lgsubmitReject" 
                                             onserverclick="SubmitReject_Click" > Reject <span class="glyphicon glyphicon-remove"></span>
                                        </button>
                                        <button id="Approve" runat="server" type="button" class="btn btn-success btn-lg" onserverclick="Approve_Click">
                                            Approve   <span class="glyphicon glyphicon-ok"></span>
                                        </button>

                                         
                                    </td>
                                </tr>
                                <tr>
                                     <td colspan="6" align="center">
                                        Note: <asp:TextBox ID="TextBoxReason" runat="server" CssClass="input input-lg Note" TextMode="MultiLine" Width="100%" ></asp:TextBox></p>
                                    </td>
                                </tr>
                        </asp:Panel>
                      </table>
                    </div>
                  </FooterTemplate>
                </asp:Repeater>
                 <asp:ObjectDataSource ID="QuoteObjectDataSource" runat="server" EnablePaging="False" SelectMethod="GetQuotebyID"
                     TypeName="QuotePresenter" OnObjectCreating="QuoteObjectDataSource_ObjectCreating" DataObjectTypeName="Quote">
                    <SelectParameters>
                       <asp:QueryStringParameter QueryStringField="QHeaderID" Name="QuoteHeaderID" />
                    </SelectParameters>
                </asp:ObjectDataSource> 
               
            </div>
        </div>
     <%--  <div id="rejectModal" class="modal fade" tabindex="-1" role="dialog">
           <div class="modal-dialog">
               <div class="modal-content">
                   <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                       <h4 class="modal-title">Please Enter the reason you are rejecting this Quote.</h4>
                   </div>
                   <div class="modal-body">
                       <p>
                       <asp:TextBox ID="TextBoxReason" runat="server" CssClass="input input-lg" TextMode="MultiLine" Width="100%" ></asp:TextBox></p>
                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-danger btn-lg" data-dismiss="modal">Cancel</button>
                       <button id="Submit" runat="server" type="button" class="btn btn-info btn-lg" onserverclick="SubmitReject_Click">Submit</button>
                   </div>
               </div>
               <!-- /.modal-content -->
           </div>
           <!-- /.modal-dialog -->
       </div>--%>
       <!-- /.modal -->
   </div>
  
  
<%--    <table class="table table-bordered">
         <thead>
    <tr>
      <th>#</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Username</th>
    </tr>
  </thead>
    </table>--%>
  <%--  <asp:Button ID="Button1" runat="server" Text="Show Report" CssClass="btn-lg btn-success" OnClick="Button1_Click"  />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" ProcessingMode="Remote"
         WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" >
        <ServerReport ReportPath="/Reports/" ReportServerUrl="ssi-sql/reportserver" />

    </rsweb:ReportViewer>--%>
    <script>

        $(function () {
            CreateScripts();
        });
        function CreateScripts() {
            $('.reject').click(function (event) {
               
                var note = $('.Note');
                var button = $('.submitReject');

                if (note.val() == '') {
                    note.addClass('noteBorder');
                    alert('You must provide a note before Submitting!');
                    note.focus();

                    //event.preventDefault();
                }
                else {
                    note.removeClass('noteBorder');
                    button.click();

                }
            });
        }
       
    </script> 
<style>
    .noteBorder{
        border-color:red;
        border-width: 3px;
        border-style: solid;
    }
</style>
</asp:Content>

