<%@ Page Title="Supreme Intranet Menu System" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="menu.aspx.cs" Inherits="MenuSystem_menu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" Runat="Server">

   <center>
       <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="50%">
        <table >
        <tr>
            <td style="color:#003366">Title Goes Here</td>
        </tr>
        <tr>
        <td>
            <br />
            <br />
            <br />
            <br />
            <br />
        </td>
        </tr>
      </table>
       </asp:Panel>
       <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" 
       TargetControlID="Panel1" Radius="5">
       </asp:RoundedCornersExtender>
    </center>
</asp:Content>


