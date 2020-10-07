<%@ Page Language="VB" MasterPageFile="~/MasterPageWebApps.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
   <style>
       a
       {
           text-decoration: none;
            color:#003366 ;
       }
           a:visited 
           {
               color: #003366;
           }

   </style>
    <center>
        <br />
        <br />
        <table>
            <tr>
                <td style="color: #003366; font-size: large">
                    <strong>Welcome to the Stim Services Intranet! Please use the links below to Navigate: </strong>
                </td>
            </tr>
        </table>
        <br />
        <table align="center">
            <tr>
                <td align="right"><img src="Graphics/add.jpg" />&nbsp;&nbsp;</td>
                <td align="left"><a href="STIM/CertificateofCompliance.aspx" xml:lang>Create Cert</a></td>
            </tr>
            <tr>
                <td align="right"><img src="Graphics/EditPencil.png" />&nbsp;&nbsp;</td>
                <td align="left"><a href="STIM/CertImageOrder.aspx" xml:lang>  Add/Edit Cert Images</a></td>
            </tr>
        </table>

        
       
    </center>
</asp:Content>
