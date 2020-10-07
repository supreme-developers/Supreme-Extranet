<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSTIM.master" AutoEventWireup="true"
    CodeFile="CertImageOrder_Old.aspx.cs" Inherits="STIM_CertImageOrder" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <center>
        <style>
            .rotWrapper
            {
                height: 260px;
                font-family: Arial;
                padding: 190px 0 0;
                width: 750px;
                background: #fff url("travel_back.jpg") no-repeat 0 0;
                font: 14px 'Segoe UI' , Arial, Sans-serif;
                color: #000;
            }
            
            .RemoveRotatorBorder div.rrClipRegion
            {
                border: 0 none;
            }
        </style>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager2" runat="server" ScriptMode="Release" />
        <telerik:RadSkinManager ID="SkinManager" runat="server" ShowChooser="true" Skin="Windows7" />
        <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" />
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadRotator1" EventName="ItemClick">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadListViewMainImage" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonMainImage">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
            <div class="loading">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Graphics/loading_imagewithword.gif"
                    AlternateText="loading"></asp:Image>
            </div>
        </telerik:RadAjaxLoadingPanel>
        <table>
            <tr>
                <td align="center">
                    <asp:Label ID="Label1" runat="server" Text="Certificate Number Supporting Images Maintenance"
                        CssClass="HeaderLabel"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                <asp:Label ID="Label3" CssClass="Labels" runat="server" Text="Logged in as:"></asp:Label>
                    <asp:Label ID="LabelUSER" CssClass="Labels" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBoxCertID" runat="server" Visible="false" Text=""></asp:TextBox>
                    <asp:TextBox ID="TextBoxImageOrder" runat="server" Visible="false" Text="1"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <table>
            <tr>
                <td align="right">
                    <div class="details">
                        <strong>
                            <asp:Label ID="label2" runat="server" Text="Cert Number:"></asp:Label>
                        </strong>
                    </div>
                </td>
                <td align="left">
                    <telerik:RadComboBox ID="RadComboBoxCertNum" runat="server" DataValueField="CertificationID"
                        PostBackUrl="CertImageOrder.aspx?" DataTextField="CertificationNumber" DataSourceID="SqlDataSource1"
                        AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="Select a Cert Number" Value="-1" Font-Italic="true"
                                Selected="true" />
                        </Items>
                    </telerik:RadComboBox>&nbsp; &nbsp;
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="select distinct I.CertificationID, C.CertificationNumber
                                               from tblSTIM_ImageLibrary I
                                               inner join tblSTIM_Certification C on I.CertificationID = c.CertificationID "
                        ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                        
                        
                        <telerik:RadButton ID="RadButtonCreateNew" runat="server" Text="Add Images" OnClientClick="OpenWnd();return false;">
                                <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                        </telerik:RadButton>
                  
                    <asp:Button ID="Button1" runat="server" Text="Button" OnClientClick="OpenWnd();return false;" />

                    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                    <Windows>
                        <telerik:RadWindow ID="RadWindow1" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="Panel3" runat="server" Style="display: " Width="100%">
                                        <table>
                                            <tr>
                                                <td align="center">
                                                    <telerik:RadAsyncUpload ID="RadAsyncUpload2" runat="server" AllowedFileExtensions="pdf,jpeg,gif,jpg,png"
                                                        MultipleFileSelection="Automatic" AllowedMimeTypes="image/tiff,image/png,image/jpeg,image/gif">
                                                    </telerik:RadAsyncUpload>
                                                    <telerik:RadProgressArea ID="RadProgressArea1" runat="server">
                                                    </telerik:RadProgressArea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <table>
                                                        <tr>
                                                            <td align="center">
                                                                <br />
                                                                <telerik:RadButton ID="RadButtonUpload" runat="server" Text="Upload" OnClick="RadButtonUpload_Click">
                                                                    <Icon PrimaryIconCssClass="rbUpload" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                                </telerik:RadButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                        </ContentTemplate>
                        </telerik:RadWindow>
                    </Windows>
                    </telerik:RadWindowManager>

                </td>
            </tr>
        </table>
        <br />
        <asp:Panel ID="Panel1" runat="server">
            <table>
                <tr>
                    <td align="right">
                        <table>
                            <tr>
                               
                                <td align="center">
                                    <telerik:RadListView ID="RadListViewMainImage" runat="server" DataSourceID="SqlDataSourceMainImage"
                                        AllowPaging="false" Visible="true" ItemPlaceholderID="ImagesContainer" DataKeyNames="ImageID">
                                        <LayoutTemplate>
                                            <div style="width: 100%; border: 1">
                                                <asp:PlaceHolder ID="ImagesContainer" runat="server"></asp:PlaceHolder>
                                            </div>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <div style="border-width: 1">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" Visible="true" DataValue='<%#Eval("BinaryImage") %>'
                                                                AutoAdjustImageControlSize="false" Width="400px" Height="300px"></telerik:RadBinaryImage>
                                                        </td>
                                                        <td align="left">
                                                            <div class="infoPaneBg" runat="server" id="detailsPanel">
                                                                <div class="imageDetailsHeader">
                                                                    Image Details</div>
                                                                <div id="viewPanel">
                                                                    <div class="details">
                                                                        <strong>Image Name:</strong>&nbsp;
                                                                        <asp:Label ID="labelImageName" runat="server" Text='<%#Eval("filename") %>'></asp:Label></div>
                                                                    <div class="details">
                                                                        <strong>Uploader:</strong>&nbsp;
                                                                        <asp:Label ID="labelImageUser" runat="server" Text='<%#Eval("UploadedUser") %>'></asp:Label></div>
                                                                    <div class="details">
                                                                        <strong>Date/time Uploaded:</strong>&nbsp;
                                                                        <asp:Label ID="labelDate" runat="server" Text='<%#Eval("UploadDate") %>'></asp:Label></div>
                                                                    <div class="details">
                                                                        <strong>Image Order #:</strong>&nbsp;
                                                                        <asp:Label ID="labelImageOrder" runat="server" Text='<%#Eval("ImageOrder") %>'></asp:Label>
                                                                    </div>
                                                                    <div class="details">
                                                                        <br />
                                                                        <telerik:RadButton ID="RadButtonMainImage" runat="server" Text="Set as Main Image"
                                                                            Visible='<%# ! (Eval("ImageOrder").ToString() == "1") %>' OnClick="RadButtonMainImage_Click"
                                                                            ImageOrder='<%#Eval("ImageOrder") %>' CommandArgument='<%#Eval("ImageID") %>'>
                                                                            <Icon PrimaryIconCssClass="rbConfig" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                                                                        </telerik:RadButton>
                                                                    </div>
                                                                    <div class="details">
                                                                        <strong>
                                                                            <asp:Label ID="label2" runat="server" Text="This is the Main Image." Visible='<%#  (Eval("ImageOrder").ToString() == "1") %>'></asp:Label></strong></div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadListView>
                                    <asp:SqlDataSource ID="SqlDataSourceMainImage" runat="server" SelectCommand="Select BinaryImage,I.[File_Name] as filename, U.FirstName + ' ' + U.LastName as UploadedUser, I.Uploaded_Datetime as UploadDate, I.ImageOrder,I.ImageID
                                                From tblSTIM_ImageLibrary I
                                                inner join usysPasswords U on I.Uploaded_UserID = U.UserID
                                                Where I.CertificationID = @CertID and I.ImageOrder = @ImageOrder " ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"
                                        UpdateCommand="Update tblSTIM_ImageLibrary set ImageOrder = @ImageOrder where ImageOrder = 1 and CertificationID = @CertificationID;
                                                    Update tblSTIM_ImageLibrary Set ImageOrder = 1
                                                    Where ImageID = @ImageID">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadComboBoxCertNum" Name="CertID" />
                                            <asp:ControlParameter ControlID="TextBoxImageOrder" Name="ImageOrder" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ImageID" />
                                            <asp:ControlParameter ControlID="TextBoxImageOrder" Name="ImageOrder" />
                                            <asp:ControlParameter ControlID="RadComboBoxCertNum" Name="CertificationID" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <table>
            <tr>
                <td align="center">
                            <telerik:RadRotator ID="RadRotator1" runat="server" Width="800px" ItemWidth="200"
                                ScrollDirection="Left, Right" Height="283px" ItemHeight="163" ScrollDuration="900"
                                FrameDuration="2000" PauseOnMouseOver="false" RotatorType="CoverFlowButtons"
                                InitialItemIndex="4" OnClientItemShown="OnClientItemShown" OnClientItemClicked="OnClientItemClicked"
                                CssClass="RemoveRotatorBorder" DataSourceID="SqlDataSourceImages" OnItemClick="Rotator1_ItemClick"
                                WrapFrames="true" >
                                <ItemTemplate>
                                    <asp:Label CssClass="info" ID="LabelID" Style="display: none" runat="server" Text='<%# Eval("ImageOrder")%>'></asp:Label>
                                    <telerik:RadBinaryImage runat="server" ID="RadBinaryImage2" DataValue='<%#Eval("BinaryImage") %>'
                                        AutoAdjustImageControlSize="true" Width="90px" Height="110px" />
                                </ItemTemplate>
                            </telerik:RadRotator>
                       
                    
                    <script type="text/javascript">
                //<![CDATA[

                        var animationOptions = {
                            minScale: 0.8, // The size scale [0; 1], applied to the items that are not selected.
                            yO: 60, // The offset in pixels of the center of the selected item from the top edge of the rotator.
                            xR: -30, // The offset in pixels between the selected items and the first item on the left and on the right of the selected item.
                            xItemSpacing: 50, // The offset in pixels between the items in the rotator.
                            matrix: { m11: 1, m12: 0, m21: -0.1, m22: 1 }, // The 2d transformation matrix, applied to the items that appear on the right of the selected item.
                            reflectionHeight: 0.5, // The height of the reflection
                            reflectionOpacity: 1 // The opacity, applied to the reflection
                        }

                        // The set_scrollAnimationOptions method takes two arguments - the first one is the ClientID of the rotator, which we want to configure and the second one is
                        // a hash table with the options we want to apply.
                        Telerik.Web.UI.RadRotatorAnimation.set_scrollAnimationOptions("<%= RadRotator1.ClientID %>", animationOptions);
                //]]>
                    </script>
                    <script type="text/javascript">
    //<![CDATA[
                        var indexToScrollTo = -1;
                        function OnClientItemShown(oRotator, args) {
                            if (oRotator.get_rotatorType() == Telerik.Web.UI.RotatorType.CoverFlow) {
                                var currentIndex = args.get_item().get_index();
                                // Change the scroll direction of the rotator, in case it has displayed its last item for the current scroll direction.
                                if (0 == currentIndex || currentIndex == (oRotator.get_items().length - 1)) {
                                    var directionEnum = Telerik.Web.UI.RotatorScrollDirection;
                                    var newScrollDirection = 0 == currentIndex ? directionEnum.Left : directionEnum.Right;

                                    oRotator.set_scrollDirection(newScrollDirection);
                                    oRotator.set_animationDirection(newScrollDirection);
                                }
                            }
                        }

                        function OnClientItemClicked(oRotator, args) {
                            oRotator.set_currentItemIndex(args.get_item().get_index(), true);
                        }


                        function OpenWnd() {
                            alert('eric');
                            radopen(null, "RadWindow1");
                        }
                
        //]]>
                    </script>
                    <asp:SqlDataSource ID="SqlDataSourceImages" runat="server" SelectCommand="Select ImageOrder, BinaryImage From tblSTIM_ImageLibrary Where CertificationID = @CertID Order By ImageOrder"
                        ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="RadComboBoxCertNum" Name="CertID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </center>
</asp:Content>
