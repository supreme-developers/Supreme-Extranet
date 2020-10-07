<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MainMaster.master" AutoEventWireup="true" CodeFile="ViewDeliveryTicket.aspx.cs" Inherits="ViewDeliveryTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .addOn{
            background-color: #51F11F;
            color:black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" Runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="well col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
                 <asp:Repeater ID="repeater1" runat="server" DataSourceID="DTObjectDataSource" OnItemDataBound="Repeater1_ItemDataBound"
                     >
                  <HeaderTemplate>
                        <div class="row">
                            <asp:Panel ID="PanelDiscrep" runat="server" Visible="false">
                                <div class="row">
                                    <div colspan="6" align="center" class="text-danger fa-3x">
                                        <span class="glyphicon glyphicon-exclamation-sign "></span>
                                        This Delivery Ticket has a Discrepancy Report!
                                    </div>
                                </div>
                                <div class="row">
                                    <div colspan="6" align="center">
                                        <a class="btn btn-danger btn-lg reject" href="DTDiscrepancyReport.aspx?DTID=<%=Convert.ToInt32(Request.QueryString["DTID"]) %>">
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
                                <h1>Delivery Ticket:  <asp:Label ID="LabelDTNumber" runat="server" Text=""></asp:Label> </h1>                                
                            </div>
                         
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th>Quantity</th>
                                        <th>Item Descr</th>                                        
                                        <th class="text-center">Min. Rental Days</th>
                                        <th class="text-center">Min.</th>
                                        <th class="text-center">Add. Day</th>
                                    </tr>
                                </thead>
                  </HeaderTemplate>
                  <ItemTemplate>
                         <tr ><td colspan="6" class="col-md-12 text-center text-capitalize text-info" style="border:None">
                             <h4>  <strong><i><asp:Literal ID="PrintType" runat="server"></asp:Literal></i> </strong></h4> </td></tr>
                          <tr >
                               <td class="col-md-1" style="text-align: center"> <%# Eval("Quantity") %> </td>
                                <td class='<%# Convert.ToBoolean(Eval("AddOn")) == true ? "addOn col-md-8" : "col-md-8" %>'><em><%# Eval("ItemDescription") %></em></h4></td>                               
                                <td class="col-md-1 text-center"><%# Eval("MinRentalDays") %></td>
                                <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "NetMin"))%></td>
                                <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "NetAddDay")) %></td>
                               
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
                            
                     
                       <asp:Panel ID="PanelDiscrep" runat="server" Visible="false">
                            <tr>
                                <td colspan="6" align="center" class="text-danger fa-3x">
                                    <span class="glyphicon glyphicon-exclamation-sign ">  </span>
                                    This Delivery Ticket has a Discrepency Report!
                                </td>
                            </tr>
                            <tr>
                               <td colspan="6" align="center" >
                                   <a class="btn btn-danger btn-lg reject" href="DTDiscrepancyReport.aspx?DTID=<%=Convert.ToInt32(Request.QueryString["DTID"]) %>"  >
                                            <span class="glyphicon glyphicon-list-alt"></span> View Report 
                                    </a>

                               </td>
                           </tr>
                          <%-- <tr>
                               <td colspan="6" align="center" >
                                   <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" Font-Size="X-Large" style="cursor:pointer; padding:5px"
                                        OnCheckedChanged="CheckBox1_CheckedChanged" Text="&nbsp;I acknowledge that I have read the Discrepency Report! " /> 
                               </td>
                           </tr>--%>
                               
                        </asp:Panel>
                   
                      </table>
                    </div>
                  </FooterTemplate>
                </asp:Repeater>
                 <asp:ObjectDataSource ID="DTObjectDataSource" runat="server" EnablePaging="False" SelectMethod="GetDTbyDTID"
                     TypeName="DTPresenter" DataObjectTypeName="DeliveryTicket">
                    <SelectParameters>
                       <asp:QueryStringParameter QueryStringField="DTID" Name="DTID" />
                    </SelectParameters>
                </asp:ObjectDataSource> 
                <asp:Panel ID="PanelMessage" runat="server" Visible="False">
                        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
                    
                </asp:Panel>
            </div>
        </div>
   
   </div>
</asp:Content>

