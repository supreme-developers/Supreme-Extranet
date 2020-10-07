<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MainMaster.master" AutoEventWireup="true" CodeFile="DiscrepancyReport.aspx.cs" Inherits="DiscrepancyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" Runat="Server">
     <div class="container-fluid">
        <div class="row">
            <div class="well col-xs-10 col-sm-10 col-md-8 col-md-offset-2">
                 <asp:Repeater ID="repeater1" runat="server" DataSourceID="QuoteObjectDataSource" OnItemDataBound="Repeater1_ItemDataBound">
                  <HeaderTemplate>
                        <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6 text-left">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Quote Number:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="Quote" runat="server"></asp:Literal><em></td>
                                </tr>
                                 <tr>
                                    <td class="text-right  text-info text-nowrap"><strong>Quote Date:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="QDate" runat="server"></asp:Literal><em></td>
                                </tr>
                                
                            </table>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 text-right">
                            <table class="table borderless">
                                <tr>
                                    <td class="text-right text-info text-nowrap"><strong>Customer:</strong></td>
                                    <td class="text-left "><em><asp:Literal ID="Customer" runat="server"></asp:Literal><em><em></td>
                                </tr>
                           
                                 <tr>
                                    <td class="text-right  text-nowrap text-info"><strong>Job Type:</strong></td>
                                    <td class="text-left"><em><asp:Literal ID="JobType" runat="server"></asp:Literal><em></td>
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
                                        <td  align="center" colspan="2">
                                           <strong> Codes</strong>
                                        </td>
                                         <td colspan="2" align="center">
                                           <strong> Minimum</strong>
                                        </td>
                                         <td colspan="2" align="center">
                                           <strong> Add Day</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Item</th>
                                        <th>Item Descr</th>                                        
                                        <th class="text-center">Min</th>
                                        <th class="text-center">Add Day</th>
                                        <th class="text-center">Not in Book</th>
                                        <th class="text-center">Quote </th>
                                        <th class="text-center">Catalog </th>
                                        <th>Quote</th>
                                        <th>Catalog</th>
                                    </tr>
                                </thead>
                  </HeaderTemplate>
                  <ItemTemplate>
                         <tr ><td colspan="6" class="col-md-12 text-center text-capitalize text-info" style="border:None">
                             <h4>  <strong><i><asp:Literal ID="PrintType" runat="server"></asp:Literal></i> </strong></h4> </td></tr>
                          <tr >
                              <td class="col-md-1" style="text-align: center"><%# Eval("Item") %> </td>
                              <td class="col-md-6"><em><%# Eval("ItemDescription") %></em></h4></td>
                              <td class="col-md-1 text-center"><em><%# Eval("MinimumCode") %></em></h4></td>
                              <td class="col-md-1  text-center"><em><%# Eval("AddDayCode") %></em></h4></td>
                              <td class="col-md-1  text-center"><em><%# Eval("NotInPCBook") %></em></h4></td>
                              <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "QuoteMinimum"))%></td>
                              <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "CatalogMinimum")) %></td>
                              <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "QuoteAddDay")) %></td>
                              <td class="col-md-1 text-center"><%# String.Format("{0:c}",DataBinder.Eval(Container.DataItem, "CatalogAddDay")) %></td>
                          </tr>
                     
                  </ItemTemplate>
                  <FooterTemplate>
                      </table>
                    </div>
                  </FooterTemplate>
                </asp:Repeater>
                 <asp:ObjectDataSource ID="QuoteObjectDataSource" runat="server" EnablePaging="False" SelectMethod="GetQuoteDiscrepancy"
                     TypeName="QuotePresenter" DataObjectTypeName="QuoteDiscrepancy">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="QuoteHeaderID" QueryStringField="QHeaderID" />
                    </SelectParameters>
                </asp:ObjectDataSource> 
                <asp:Panel ID="PanelMessage" runat="server" Visible="False">
                        <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
                    
                </asp:Panel>
            </div>
        </div>
         <div class="row">
             <div class="col-lg-9 col-lg-offset-2">
                 <a class="btn btn-lg btn-info" href="Quote.aspx?QHeaderID=<%=Convert.ToInt32(Request.QueryString["QHeaderID"]) %>">
                      <span class="glyphicon glyphicon-arrow-left"></span> Back to Quote
                 </a>
             </div>
         </div>
             

   
       <!-- /.modal -->
   </div>
</asp:Content>

