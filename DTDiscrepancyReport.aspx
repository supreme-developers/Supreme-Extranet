<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MainMaster.master" AutoEventWireup="true" CodeFile="DTDiscrepancyReport.aspx.cs" Inherits="DTDiscrepancyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>
    <style>
        .bolder
        {
            font-weight:800;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" Runat="Server">
     <div class="container-fluid">
        <div class="row">
            <div class="well col-xs-10 col-sm-10 col-md-8 col-md-offset-2">
                 <asp:Repeater ID="repeater1" runat="server" DataSourceID="DTDiscrepObjectDataSource" OnItemDataBound="Repeater1_ItemDataBound">
                  <HeaderTemplate>
                        <div class="row">
                        <div class="col-xs-4 col-sm-4 col-md-4 text-left">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Delivery Ticket:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="DT" runat="server"></asp:Literal><em></td>
                                </tr>
                                
                                
                            </table>
                        </div>
                        <div class="col-xs-4 col-sm-4 col-md-4 text-left">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Invoice Number:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="InvoiceNumber" runat="server"></asp:Literal><em></td>
                                </tr>
                            </table>
                        </div>
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                 <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Quote #:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="Quote" runat="server"></asp:Literal><em><em></td>
                                </tr>
                                
                            </table>
                            </div>
                
                    </div>
                    <div class="row">
                          <%--  <div class="text-center">
                                <h1>Quote #:<asp:Label ID="LabelQuoteNumber" runat="server" Text=""></asp:Label> </h1>
                                <h4>Status: <i><asp:Label ID="LabelStatus" runat="server" Text=""></asp:Label></i> </h4>
                                
                            </div>--%>
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <td></td>
                                       <td></td>
                                        <td  align="center" colspan="3" class="fa-1x">
                                           <strong> DT/Invoice</strong>
                                        </td>
                                         <td colspan="3" align="center" class="fa-1x">
                                           <strong>Quote</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Code</th>
                                        <th>Item Descr</th>                                        
                                        <th class="text-center">Qty</th>
                                        <th class="text-center">Min</th>
                                        <th class="text-center">Add Day</th>
                                        <th class="text-center">Qty </th>
                                        <th class="text-center">Min </th>
                                        <th class="text-center">Add Day</th>
                                    </tr>
                                </thead>
                  </HeaderTemplate>
                  <ItemTemplate>
                         <tr >
                             <td colspan="6" class="col-md-10 col-md-offset-2 col-lg-offset-2 text-left text-capitalize text-info" style="border:None">
                             <h4>  <strong><i><asp:Literal ID="DiscrepancyType" runat="server"></asp:Literal></i> </strong></h4> </td>

                         </tr>
                          <tr >
                              <td class="col-md-1"><em><%# Eval("Code") %></em></h4></td>
                              <td class="col-md-6"><em><%# Eval("ItemDescription") %></em></h4></td>
                              <td class="col-md-1 text-center <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "Quantity")) != Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteQuantity")) &&  
                                      Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>">
                                  <em><%# Eval("Quantity") %></em></h4></td>
                              <td class="col-md-1 text-center <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteMinimum")) != Convert.ToDouble(DataBinder.Eval(Container.DataItem, "Minimum")) &&  Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>">
                                  <%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "Minimum"))%></td>
                              <td class="col-md-1 text-center <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "AddDay")) != Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteAddDay")) &&  Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>">
                                  <%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "AddDay")) %></td>
                              <td class="col-md-1 text-center <%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) == false ? " hidden" : ""%> 
                                  <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "Quantity")) != Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteQuantity")) &&  Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>"><em><%# Eval("QuoteQuantity") %></em></h4></td>
                              <td class="col-md-1 text-center <%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) == false ? " hidden" : ""%> 
                                  <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteMinimum")) != Convert.ToDouble(DataBinder.Eval(Container.DataItem, "Minimum")) &&  Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "QuoteMinimum"))%></td>
                              <td class="col-md-1 text-center <%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) == false ? " hidden" : ""%> <%# Convert.ToDouble(DataBinder.Eval(Container.DataItem, "AddDay")) != 
                                      Convert.ToDouble(DataBinder.Eval(Container.DataItem, "QuoteAddDay")) 
                                      &&  Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "PrintColumn")) ? " bolder" : ""%>"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "QuoteAddDay")) %></td>
                          </tr>
                     
                  </ItemTemplate>
                  <FooterTemplate>
                      </table>
                    </div>
                  </FooterTemplate>
                </asp:Repeater>
                 <asp:ObjectDataSource ID="DTDiscrepObjectDataSource" runat="server" EnablePaging="False" SelectMethod="GetDTDiscrepancy"
                     TypeName="DTPresenter" DataObjectTypeName="DTDiscrepancy">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="DTID" QueryStringField="DTID" />
                    </SelectParameters>
                </asp:ObjectDataSource> 
                <asp:Panel ID="PanelMessage" runat="server" Visible="False">
                        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
                    
                </asp:Panel>
            </div>
        </div>
         <div class="row">
             <div class="col-lg-9 col-lg-offset-2">
                 <a class="btn btn-lg btn-info" href="ViewDeliveryTicket.aspx?DTID=<%=Convert.ToInt32(Request.QueryString["DTID"]) %>">
                      <span class="glyphicon glyphicon-arrow-left"></span> Back to Delivery Ticket
                 </a>
             </div>
         </div>
             

   
       <!-- /.modal -->
   </div>
</asp:Content>

