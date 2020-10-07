<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSTIM.master" AutoEventWireup="true"
    CodeFile="CertificateofCompliance.aspx.cs" Inherits="STIM_CertificateofCompliance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">

    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Release">
    </asp:ToolkitScriptManager>


    <center>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">

                function OnClientFileUploadFailed(sender, args) {
                    if (args.get_message() == "error") {
                        args.set_handled(true);
                        alert(args.get_message());
                    }
                }

                var currentSlideNumber = 0;
                var slidesCount;
                var slideInterval = null;
               

                function CallPrint(sender, eventArgs) {

                    var prtContent = document.getElementById('Printmeonly');
                    var prtImage = document.getElementById('slide_01');
                    var WinPrint = window.open('', '', 'left=0,top=0,width=1,height=1,toolbar=0,scrollbars=0,status=0');
                    WinPrint.document.write(prtContent.innerHTML);
                    //WinPrint.document.write(prtImage.innerHTML);
                    WinPrint.document.close();
                    WinPrint.focus();
                    WinPrint.print();
                    WinPrint.close();
                    return true;
                }

                function UpdateVisibleSlide(sender, args) {
                    var slider = sender;
                    if (!slidesCount) {
                        slidesCount = slider.get_items().length;
                    }

                    SelectSlide(slider.get_value());
                }
                function AddNew(sender, args) {
                    window.location = 'CertificateofCompliance.aspx';
                }

                function SelectSlide(slideNumber) {
                    var currentSlide = $get('slide_0' + currentSlideNumber);
                    if (currentSlide) {
                        currentSlide.style.display = '';
                    }

                    currentSlideNumber = slideNumber;
                    currentSlide = $get('slide_0' + currentSlideNumber);
                    currentSlide.style.display = 'block';
                }

                function SelectPrevSlide(stopSlideShow) {
                    if (stopSlideShow) {
                        StopSlideShow();
                    }

                    var slider = $find('<%= RadSlider1.ClientID %>');

                    var slideNumber = currentSlideNumber - 1;
                    if (slideNumber == -1) {
                        slideNumber = slidesCount - 1;
                    }

                    slider.set_value(slideNumber);
                    SelectSlide(slideNumber);
                }

                function SelectNextSlide(stopSlideShow) {
                    if (stopSlideShow) {
                        StopSlideShow();
                    }

                    var slider = $find('<%= RadSlider1.ClientID %>');

                    var slideNumber = currentSlideNumber + 1;
                    if (slideNumber > (slidesCount - 1)) {
                        slideNumber = 0;
                    }

                    slider.set_value(slideNumber);
                    SelectSlide(slideNumber);
                }

                function StopSlideShow() {
                    if (!slideInterval) return;

                    TogglePlaySlideShow($get('playButton'));
                }

                function TogglePlaySlideShow(button) {
                    var toEnable = false;
                    if (button.title == 'Play Slideshow') {
                        slideInterval = window.setInterval('SelectNextSlide()', 1000);

                        button.title = 'Stop Slideshow';
                        button.className = 'stop';
                    }
                    else if (button.title == 'Stop Slideshow') {
                        toEnable = true;

                        window.clearInterval(slideInterval);
                        slideInterval = null;

                        button.title = 'Play Slideshow';
                        button.className = 'play';
                    }

                    var slider = $find('<%= RadSlider1.ClientID %>');
                    slider.set_enabled(toEnable);
                    slider.repaint();
                }

             
            </script>
        </telerik:RadCodeBlock>
        <table>
            <tr>
                <td align="center">
                    <asp:Label ID="Label1" runat="server" Text="Certificate of Compliance" CssClass="HeaderLabel"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LabelUSER" CssClass="Labels" Font-Size runat="server" Text="Logged in as: "></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadComboBoxTestType" EventName="SelectedIndexChanged">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                       
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadComboBoxCustomer">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Step1PanelItem1" />
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonStep1Next">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="RadPanelBar1"  />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadComboBoxUnitNum">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonStep3Next">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadTabStrip1" />
                        <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonStep7Next">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadTabStrip1" />
                        <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonUpload">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadListView1" />
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadButtonGotoPrint">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" />
                        <telerik:AjaxUpdatedControl ControlID="RadTabStrip1" />
                        <telerik:AjaxUpdatedControl ControlID="FormViewPadEyes" />
                        <telerik:AjaxUpdatedControl ControlID="CertNumPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxPanel runat="server" ID="CertNumPanel">
            <table>
                <tr>
                    <td align="right">
                        <asp:Label ID="LabelCertNum" CssClass="Labels" Visible="false" runat="server" Text="Cert #:"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="LabelCertNumber" Visible="false" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
                    </td>
                    <td align="right">
                        <asp:Label ID="LabelCertStatus" CssClass="Labels" Visible="false" runat="server"
                            Text="Cert Status:"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="LabelCertificateStatus" Visible="false" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxCertStatusID" runat="server" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxInventoryID" runat="server" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxCertID" runat="server" Visible="false" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxUser" runat="server" Visible="false" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="LabelCustomerError" CssClass="Labels" Visible="false" runat="server"
                            Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </telerik:RadAjaxPanel>
        <br />
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="" Transparency="30">
            <div class="loading">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Graphics/loading_imagewithword.gif"
                    AlternateText="loading"></asp:Image>
            </div>
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadSkinManager ID="SkinManager" runat="server" ShowChooser="false" Skin="Outlook" />
        <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All"
            Skin="Outlook" />
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
            Width="800px" SelectedIndex="0">
            <Tabs>
                <telerik:RadTab Text="Certification" runat="server" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab Text="Inspection" runat="server" Enabled="false">
                </telerik:RadTab>
                <telerik:RadTab Text="Upload Images" runat="server" Enabled="false" >
                </telerik:RadTab>
                <telerik:RadTab Text="Print/View Cert" runat="server" Enabled="false" ImageUrl="~/Graphics/printer_icon.png"
                    DisabledImageUrl="">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" BorderWidth="1">
            <telerik:RadPageView runat="server" ID="RadPageView1">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
                    <telerik:RadPanelBar ID="RadPanelBar1" runat="server" Width="800px" ExpandMode="SingleExpandedItem"
                        AllowCollapseAllItems="true" BackColor="#BFCEE1">
                        <CollapseAnimation Duration="500" Type="InCubic" />
                        <ExpandAnimation Duration="500" Type="InCubic" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Text="Step 1: General Information" runat="server"
                                Selected="true" BackColor="#BFCEE1" Value="Step1">
                                <Items>
                                    <telerik:RadPanelItem runat="server" BackColor="#BFCEE1" Value="Step1PanelItem1">
                                        <ItemTemplate>
                                            <asp:Panel ID="Panel8" runat="server" BackColor="#BFCEE1" Visible="true">
                                                <br />
                                                <table align="center">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="Label2" runat="server" Text="Customer:" CssClass="Labels"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <telerik:RadComboBox ID="RadComboBoxCustomer" runat="server" DataSourceID="SqlDataSourceCustomers"
                                                                AutoPostBack="true" CausesValidation="false" EmptyMessage="Select a Customer"
                                                                DataTextField="Name" DataValueField="CustomerID" OnSelectedIndexChanged="RadComboBoxCustomer_SelectedIndexChanged"
                                                                OnDataBound="RadComboBoxCustomer_DataBound" EnableAutomaticLoadOnDemand="false"
                                                                AppendDataBoundItems="true">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="Select a Customer" Value="-1" ForeColor="Gray" Font-Italic="true"
                                                                        Selected="true" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            <asp:SqlDataSource ID="SqlDataSourceCustomers" runat="server" SelectCommand="Select Distinct tblSTIM_Customers.CustomerID, tblCustomers.[Customer Number], tblCustomers.[Customer Name] as Name
                                                                       From tblSTIM_Customers Inner Join tblCustomers on tblCustomers.CustomerID = tblSTIM_Customers.CustomerID ORDER BY tblCustomers.[Customer Number]"
                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                        </td>
                                                        <td align="right">
                                                            &nbsp;&nbsp;
                                                            <asp:Label ID="Label3" runat="server" Text=" Test Type:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <telerik:RadComboBox ID="RadComboBoxTestType" runat="server" DataSourceID="SqlDataSourceTEstType"
                                                                AutoPostBack="true" CausesValidation="false" DataTextField="CertificationType"
                                                                Enabled="false" ViewStateMode="Enabled" DataValueField="CertificationTypeID"
                                                                AppendDataBoundItems="true" EnableAjaxSkinRendering="true" EnableItemBindingExpressions="true"
                                                                EmptyMessage="Select a Test Type" EnableAutomaticLoadOnDemand="false" OnSelectedIndexChanged="RadComboBoxTestType_SelectedIndexChanged">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="Select a Test Type" Value="-1" ForeColor="Gray" Font-Italic="true"
                                                                        Selected="true" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            <asp:SqlDataSource ID="SqlDataSourceTEstType" runat="server" SelectCommand="Select CertificationTypeID, CertificationType, TestedtoPressureLevel, ReportName From tblSTIM_CertificationType  where WebUse = 1"
                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:Panel ID="PanelInfo" runat="server" BackColor="#BFCEE1" Visible="false">
                                            <telerik:RadAjaxPanel runat="server" ID="AjaxPanelInfo">
                                                <table cellpadding="10" cellspacing="10" border=".5" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:Panel ID="Panel1" runat="server">
                                                                <table style="width: 100%">
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label4" runat="server" Text="Inspection Method:" ForeColor="#003366"
                                                                                CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxInspectMeth" runat="server" >
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceInspectMeth" runat="server"  SelectCommand=" SELECT tblSTIM_MethodofInspection.MethodofInspectionID, 
                                                                                            tblSTIM_MethodofInspection.MethodofInspection, tblSTIM_MethodofInspection.WebUpload 
                                                                                            FROM tblSTIM_MethodofInspection
                                                                                            INNER JOIN tblSTIM_SchedulingRecurrences ON tblSTIM_SchedulingRecurrences.MethodofInspectionID = tblSTIM_MethodofInspection.MethodofInspectionID 
                                                                                            WHERE tblSTIM_SchedulingRecurrences.defaultRecord = 1 and tblSTIM_SchedulingRecurrences.CertificationTypeID = @CertificationTypeID "
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="RadComboBoxTestType" Name="CertificationTypeID" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadComboBoxInspectMeth"
                                                                                ErrorMessage="Inspection Method is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label11" runat="server" Text="Inventory:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:RadioButtonList ID="RadioButtonListInventory" runat="server" RepeatDirection="Horizontal">
                                                                                <asp:ListItem Selected="True" Text="Supreme"></asp:ListItem>
                                                                                <asp:ListItem Selected="False" Text="Customer"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label5" runat="server" Text="Unit #:" Visible="true" ForeColor="#003366"
                                                                                CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxUnitNum" runat="server" OnSelectedIndexChanged="RadComboBoxUnitNum_SelectedIndexChanged"
                                                                                AutoPostBack="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="RadComboBoxUnitNum"
                                                                                ErrorMessage="The Unit Number is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label10" runat="server" Text="Job #" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadTextBox ID="RadTextBoxJobNum" runat="server" EmptyMessage="Job #">
                                                                            </telerik:RadTextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RadTextBoxJobNum"
                                                                                ErrorMessage="The Job Number is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label12" runat="server" Text="Job Location" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadTextBox ID="RadTextBoxJobLoc" runat="server" EmptyMessage="Job Location">
                                                                            </telerik:RadTextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="RadTextBoxJobLoc"
                                                                                ErrorMessage="The Job Location is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                        <td>
                                                            <asp:Panel ID="Panel2" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label7" runat="server" Text="Specification #:" ForeColor="#003366"
                                                                                CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxSpecNum" runat="server" >
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceSpecNum" runat="server"
                                                                                SelectCommand="SELECT SpecificationNumberID, SpecificationNumber from tblSTIM_Certification_SpecificationNumber where CertificationTypeID =  @CertificationTypeID"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                                                             <SelectParameters>
                                                                                <asp:ControlParameter ControlID="RadComboBoxTestType" Name="CertificationTypeID" />
                                                                             </SelectParameters>  
                                                                            </asp:SqlDataSource>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="RadComboBoxSpecNum"
                                                                                ErrorMessage="The Specification # is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label9" runat="server" Text="Unit Desc:" ForeColor="#003366"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxUnitDesc" runat="server" Style="padding-top: 2px">
                                                                            </telerik:RadComboBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="RadComboBoxUnitDesc"
                                                                                ErrorMessage="The Unit Descr is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td align="right">
                                                                            <asp:Label ID="Label8" runat="server" Text="Billing Type:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxBillingType" runat="server" DataSourceID="SqlDataSourceBillingType"
                                                                                DataTextField="Description" DataValueField="InvID" ExpandAnimation-Type="InOutBack"
                                                                                MarkFirstMatch="true" EmptyMessage="Select a Billing Type" EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceBillingType" runat="server" SelectCommand="select  tblinventory.[Inventory ID] as InvID, tblinventory.[Item], tblInventory.[Description], tblInventoryPriceBookCodes.baseamount
                                                                    from (tblInventory inner join tblInventoryPriceBookCodes on tblinventorypricebookcodes.PriceCodeID = tblinventory.PriceBookID)
                                                                    inner join tblInventoryPriceBooks on tblinventorypricebooks.PriceBookID = tblInventoryPriceBookCodes.PriceBookID
                                                                    where tblinventorypricebooks.[Description] = 'STIM Price Book'" ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                                                            </asp:SqlDataSource>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="RadComboBoxBillingType"
                                                                                ErrorMessage="The Billing Type is required." ValidationGroup="Step1" Enabled="false">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td align="right">
                                                                            <asp:Label ID="Label13" runat="server" Text="PO #" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadTextBox ID="RadTextBoxPONum" runat="server" EmptyMessage="Job #">
                                                                            </telerik:RadTextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="RadTextBoxPONum"
                                                                                ErrorMessage="The PO Number is required." ValidationGroup="Step1" Enabled="false">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label14" runat="server" Text="Job Date" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadDatePicker ID="RadDatePickerJobDate" runat="server" DateInput-EmptyMessage="Job Date">
                                                                            </telerik:RadDatePicker>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="RadDatePickerJobDate"
                                                                                ErrorMessage="The Job Date is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <br />
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label6" runat="server" Text="Cert Date:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadDatePicker ID="RadDatePickerCertDate" runat="server" DateInput-EmptyMessage="Cert Date">
                                                                            </telerik:RadDatePicker>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="RadDatePickerCertDate"
                                                                                ErrorMessage="The Cert Date is required." ValidationGroup="Step1">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <telerik:RadButton ID="RadButtonStep1Next" runat="server" Text="Next" OnClick="RadButtonStep1Next_Click"
                                                                ValidationGroup="Step1" CausesValidation="false" UseSubmitBehavior="true">
                                                                <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                            </telerik:RadButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="center">
                                                            <asp:Panel ID="PanelStep1ErrorList" runat="server">
                                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" Width="240" BorderColor="Red"
                                                                    ValidationGroup="Step1" BorderWidth="3px" HeaderText="<font size='large'><b><u>Error List</u></b></font>"
                                                                    DisplayMode="List" ShowSummary="true"></asp:ValidationSummary>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </telerik:RadAjaxPanel>
                                            </asp:Panel>
                                            <asp:SqlDataSource ID="SqlDataSourceCertificationStep1" runat="server" SelectCommand="Select * From tblSTIM_Certification"
                                                InsertCommand=" Insert into tblSTIM_Certification" ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                            <telerik:RadPanelItem Enabled="false" Text="Step 2: Test Information" runat="server">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step2PanelItem">
                                        <ItemTemplate>
                                            <table style="background-color: #BFCEE1" width="100%">
                                                <tr align="center">
                                                    <td valign="middle">
                                                        <asp:Panel ID="PanelInfo" runat="server" BackColor="#BFCEE1">
                                                            <table cellpadding="10" cellspacing="10" border=".5">
                                                                <tr>
                                                                    <td align="right">
                                                                        <br />
                                                                        <asp:Panel ID="Panel1" runat="server">
                                                                            <table style="table-layout: fixed">
                                                                                <tr>
                                                                                    <td align="center" colspan="2">
                                                                                        <asp:Label ID="Label129" runat="server" Text="Pass/Fail:" CssClass="Labels"></asp:Label>
                                                                                        <telerik:RadComboBox ID="RadComboBoxRejectionStatusID" runat="server" Width="50"
                                                                                            NoWrap="true" MarkFirstMatch="true" EmptyMessage="Pass/Fail" EnableAutomaticLoadOnDemand="true">
                                                                                            <Items>
                                                                                                <telerik:RadComboBoxItem Text="Pass" Value="1" />
                                                                                                <telerik:RadComboBoxItem Text="Fail" Value="2" />
                                                                                            </Items>
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:Label ID="Label130" runat="server" Text="Mobile:" CssClass="Labels"></asp:Label>
                                                                                        <telerik:RadComboBox ID="RadComboBoxMobile" runat="server" Width="50" NoWrap="true"
                                                                                            MarkFirstMatch="true" EmptyMessage="Mobile?" EnableAutomaticLoadOnDemand="true">
                                                                                            <Items>
                                                                                                <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                                                                                <telerik:RadComboBoxItem Text="No" Value="2" />
                                                                                            </Items>
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label17" runat="server" Text="Testing Unit:" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxTestingUnit" runat="server">
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label15" runat="server" Text="Empty Weight:" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxEmptyWeight" runat="server" EmptyMessage="Empty Weight">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Labels16" runat="server" Text="Sling Type:" CssClass="Labels" Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxSlingType" runat="server" DataSourceID="SqlDataSourceSlingType"
                                                                                            DataTextField="SlingType" DataValueField="SlingTypeID" EmptyMessage="Select a Sling Type"
                                                                                            EnableAutomaticLoadOnDemand="true" Visible="false">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceSlingType" runat="server" SelectCommand="Select SlingTypeID, SlingType, DegreeOne, DegreeTwo, DegreeThr from tblSTIM_Certification_SlingType"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label4" runat="server" Text="Working Load:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxWorkingLoad" runat="server" EmptyMessage="Working Load">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label5" runat="server" Text="Max Unit Capac" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxMaxUnitCap" runat="server" EmptyMessage="Max Unit Capac.">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td align="left">
                                                                        <br />
                                                                        <asp:Panel ID="Panel2" runat="server" Width="100%">
                                                                            <table>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label2" runat="server" Text="Tested To:" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxTestedTo" runat="server" EmptyMessage="Tested to">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tralign
                                                                                <tr>
                                                                                    <td >
                                                                                        <asp:Label ID="Label7" runat="server" Text="Manufact Date:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadDatePicker ID="RadDateManDate"  runat="server" DateInput-EmptyMessage="Manufacture Date" >
                                                                                            <DateInput runat="server" ID ="Dateinput"></DateInput>
                                                                                        </telerik:RadDatePicker>
                                                                                      
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label11" runat="server" Text="Pad Eyes Legs:" ForeColor="#003366"
                                                                                            CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxNumberofLegsEyes" runat="server" EmptyMessage="Pad Eyes Legs">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label18" runat="server" Text="Sling Size:" ForeColor="#003366" CssClass="Labels"
                                                                                            Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxSlingSize" runat="server" DataSourceID="SqlDataSourceSlingSize"
                                                                                            DataTextField="SlingSize" DataValueField="SlingSizeID" NoWrap="true" ExpandAnimation-Type="InOutBack"
                                                                                            MarkFirstMatch="true" EmptyMessage="Select a Sling Size" EnableAutomaticLoadOnDemand="true"
                                                                                            Visible="false">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceSlingSize" runat="server" SelectCommand="Select SlingSizeID, SlingSize, Degree30, Degree45, Degree60 
                                                                                from tblSTIM_Certification_SlingSize" ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                                                                        </asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label19" runat="server" Text="Max Capac:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxMaxCap" runat="server" DataSourceID="SqlDataSourceSlingSize"
                                                                                            Width="50" NoWrap="true" MarkFirstMatch="true" EmptyMessage="Select a Max Capacity"
                                                                                            EnableAutomaticLoadOnDemand="true">
                                                                                            <Items>
                                                                                                <telerik:RadComboBoxItem Text="1.5" />
                                                                                                <telerik:RadComboBoxItem Text="2.0" />
                                                                                                <telerik:RadComboBoxItem Text="2.5" />
                                                                                                <telerik:RadComboBoxItem Text="CR" />
                                                                                            </Items>
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr >
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label20" runat="server" Text="Dble Max Unit Cap:" ForeColor="#003366"
                                                                                            CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextDoubleMaxUnitCapacity" runat="server">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="display: none">
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label22" runat="server" Text="45 Degree:" ForeColor="#003366" CssClass="Labels"
                                                                                            Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBox45Deg" runat="server" Width="70px" Visible="false">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="display: none">
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label21" runat="server" Text="60 Degree:" ForeColor="#003366" CssClass="Labels"
                                                                                            Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBox60" runat="server" Width="50px" Visible="false">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="center" colspan="2">
                                                                        <telerik:RadButton ID="RadButtonStep2Next" runat="server" Text="Next" OnClick="RadButtonStep2Next_Click"
                                                                             CausesValidation="false">
                                                                            <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                                        </telerik:RadButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                            <telerik:RadPanelItem Enabled="false" Text="Step 3: Personnel" runat="server">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step3PanelItem">
                                        <ItemTemplate>
                                            <table style="background-color: #BFCEE1" width="100%">
                                                <tr align="center">
                                                    <td valign="middle">
                                                        <asp:Panel ID="PanelInfo" runat="server">
                                                            <table cellpadding="10" cellspacing="10" border=".5">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Panel ID="PanelStep3" runat="server">
                                                                            <table style="table-layout: fixed">
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label3" runat="server" Text="Inspector:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxInspector" runat="server" DataSourceID="SqlDataSourceInspector"
                                                                                            DataTextField="UserName" DataValueField="UserID" EmptyMessage="Select an Inspector"
                                                                                            EnableAutomaticLoadOnDemand="true">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceInspector" runat="server" SelectCommand="Select UserID, UserName from vwtblHREmployee_ALL inner join tblHREmployee on tblhremployee.EmployeeID = vwtblhremployee_all.UserID inner join
	                                                                                                   tblHREmployeeDepartment on tblHREmployeeDepartment.DepartmentID = tblHREmployee.DepartmentID where OfficeID = 5 and tblHREmployee.TerminationDate is null order by username"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label24" runat="server" Text="Tested By:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxTestedBy" runat="server" DataSourceID="SqlDataSourceTester"
                                                                                            DataTextField="UserName" DataValueField="UserID" EmptyMessage="Select a Tester"
                                                                                            EnableAutomaticLoadOnDemand="true">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceTester" runat="server" SelectCommand="Select UserID, UserName from vwtblHREmployee_ALL inner join tblHREmployee on tblhremployee.EmployeeID = vwtblhremployee_all.UserID inner join
	                                                                                                      tblHREmployeeDepartment on tblHREmployeeDepartment.DepartmentID = tblHREmployee.DepartmentID where OfficeID = 5 and tblHREmployee.TerminationDate is null order by username"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Panel ID="Panel4" runat="server">
                                                                            <table>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label23" runat="server" Text="Level:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxLevel" runat="server" DataSourceID="SqlDataSourceLevel"
                                                                                            DataTextField="LevelPosition" DataValueField="LevelID" EmptyMessage="Select a Level"
                                                                                            EnableAutomaticLoadOnDemand="true" Width="95px">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceLevel" runat="server" SelectCommand="Select LevelID, LevelPosition from tblSTIM_Certification_Level"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label25" runat="server" Text="Witnessed By:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxWitness" runat="server" DataSourceID="SqlDataSourceWitness"
                                                                                            DataTextField="UserName" DataValueField="UserID" EmptyMessage="Select a Witness"
                                                                                            EnableAutomaticLoadOnDemand="true">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceWitness" runat="server" SelectCommand="Select UserID, UserName from vwtblHREmployee_ALL inner join tblHREmployee on tblhremployee.EmployeeID = vwtblhremployee_all.UserID inner join
	                                                                                                       tblHREmployeeDepartment on tblHREmployeeDepartment.DepartmentID = tblHREmployee.DepartmentID where OfficeID = 5 and tblHREmployee.TerminationDate is null order by username"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="center" colspan="2">
                                                                        <telerik:RadButton ID="RadButtonStep3Next" runat="server" Text="Next" OnClick="RadButtonStep3Next_Click">
                                                                            <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                                        </telerik:RadButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                            <telerik:RadPanelItem Enabled="false" Text="Step 4: Scheduling" runat="server" Visible="false">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step4PanelItem">
                                        <ItemTemplate>
                                            <table style="background-color: #BFCEE1" width="100%">
                                                <tr align="center">
                                                    <td valign="middle">
                                                        <asp:Panel ID="PanelInfo" runat="server">
                                                            <table cellpadding="10" cellspacing="10" border=".5">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Panel ID="PanelStep3" runat="server">
                                                                            <table style="table-layout: fixed">
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label3" runat="server" Text="Recurrence:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxRecurrence" runat="server" AppendDataBoundItems="true"
                                                                                            Width="90" EmptyMessage="Reccurence" AllowCustomText="false" OnItemsRequested="RadComboBoxRecurrence_ItemsRequested"
                                                                                            EnableLoadOnDemand="True">
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label26" runat="server" Text="Recurrence Quantity:" ForeColor="#003366"
                                                                                            CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadTextBox ID="RadTextBoxRecurrenceQuantity" runat="server" EmptyMessage="Recurrence Quant">
                                                                                        </telerik:RadTextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Label27" runat="server" Text="Unit of Measure:" ForeColor="#003366"
                                                                                            CssClass="Labels"></asp:Label>
                                                                                    </td>
                                                                                    <td align="left">
                                                                                        <telerik:RadComboBox ID="RadComboBoxUnitofMeasure" runat="server" AppendDataBoundItems="true"
                                                                                            DataSourceID="SqlDataSourceUOM" DataValueField="SchedulingRecurrenceUOMID" DataTextField="Description"
                                                                                            EmptyMessage="Select a Unit of Measure" Width="90" EnableAutomaticLoadOnDemand="true">
                                                                                        </telerik:RadComboBox>
                                                                                        <asp:SqlDataSource ID="SqlDataSourceUOM" runat="server" SelectCommand="Select SchedulingRecurrenceUOMID, [Description]  from tblSYS_SchedulingRecurrenceUOM"
                                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <telerik:RadButton ID="RadButtonStep4Next" runat="server" Text="Next" OnClick="RadButtonStep4Next_Click">
                                                            <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                        </telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server" BackColor="#BFCEE1">
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server">
                    <telerik:RadPanelBar ID="RadPanelBar2" runat="server" Width="800px" ExpandMode="SingleExpandedItem"
                        AllowCollapseAllItems="true">
                        <CollapseAnimation Duration="500" Type="InCubic" />
                        <ExpandAnimation Duration="500" Type="InCubic" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Text="Step 4: Inspection Information" runat="server"
                                Selected="true">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step5PanelItem">
                                        <ItemTemplate>
                                            <asp:Panel ID="Panel6" runat="server">
                                                <table style="background-color: #BFCEE1; width: 100%">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Panel ID="Panel5" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label31" runat="server" Text="Technician:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxTechnician" runat="server" DataSourceID="SqlDataSourceTechnician"
                                                                                DataTextField="UserName" DataValueField="UserID" EmptyMessage="Select a Technichian"
                                                                                EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceTechnician" runat="server" SelectCommand="Select UserID, UserName from vwtblHREmployee_ALL inner join tblHREmployee on tblhremployee.EmployeeID = vwtblhremployee_all.UserID inner join
	                                                  tblHREmployeeDepartment on tblHREmployeeDepartment.DepartmentID = tblHREmployee.DepartmentID where OfficeID = 5 and tblHREmployee.TerminationDate is null order by username"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label32" runat="server" Text="Assistant:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxAssistant" runat="server" DataSourceID="SqlDataSourceAssistant"
                                                                                DataTextField="UserName" DataValueField="UserID" EmptyMessage="Select a Assistant"
                                                                                EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceAssistant" runat="server" SelectCommand="Select UserID, UserName from vwtblHREmployee_ALL inner join tblHREmployee on tblhremployee.EmployeeID = vwtblhremployee_all.UserID inner join
	                                                  tblHREmployeeDepartment on tblHREmployeeDepartment.DepartmentID = tblHREmployee.DepartmentID where OfficeID = 5 and tblHREmployee.TerminationDate is null order by username"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label28" runat="server" Text="Total Hours:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxTotalHours" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label30" runat="server" Text="Material:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:TextBox ID="TextBoxMaterial" runat="server" TextMode="MultiLine" Height="80"
                                                                                Width="200"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="left">
                                                            <table>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Label23" runat="server" Text="Tech. Level:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <telerik:RadComboBox ID="RadComboBoxTechLevel" runat="server" DataSourceID="SqlDataSourceTechLevel"
                                                                            DataTextField="LevelPosition" DataValueField="LevelID" EmptyMessage="Select a Level"
                                                                            EnableAutomaticLoadOnDemand="true" Width="95px">
                                                                        </telerik:RadComboBox>
                                                                        <asp:SqlDataSource ID="SqlDataSourceTechLevel" runat="server" SelectCommand="Select LevelID, LevelPosition from tblSTIM_Certification_Level"
                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Label123" runat="server" Text="Asst. Level:" ForeColor="#003366" CssClass="Labels"></asp:Label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <telerik:RadComboBox ID="RadComboBoxAssistLevel" runat="server" DataSourceID="SqlDataSourceAssistLevel"
                                                                            DataTextField="LevelPosition" DataValueField="LevelID" EmptyMessage="Select a Level"
                                                                            EnableAutomaticLoadOnDemand="true" Width="95px">
                                                                        </telerik:RadComboBox>
                                                                        <asp:SqlDataSource ID="SqlDataSourceAssistLevel" runat="server" SelectCommand="Select LevelID, LevelPosition from tblSTIM_Certification_Level"
                                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Label29" runat="server" Text="Mileage:" CssClass="Labels"></asp:Label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <telerik:RadNumericTextBox ID="RadNumericTextBoxMileage" runat="server">
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Label33" runat="server" Text="Scope of Exam:" CssClass="Labels"></asp:Label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="TextBoxScopeofExamination" runat="server" TextMode="MultiLine" Height="80"
                                                                            Width="200"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <br />
                                                            <telerik:RadButton ID="RadButtonStep5Next" runat="server" Text="Next" OnClick="RadButtonStep5Next_Click">
                                                                <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                            </telerik:RadButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                            <telerik:RadPanelItem Expanded="false" Text="Step 5: Magnetic Particle" runat="server">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step6PanelItem">
                                        <ItemTemplate>
                                            <asp:Panel ID="Panel6" runat="server">
                                                <table style="background-color: #BFCEE1; width: 100%" align="center">
                                                    <tr>
                                                        <td align="center" valign="middle">
                                                            <asp:Panel ID="Panel5" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label33" runat="server" Text="Type:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxMagPartType" runat="server" DataSourceID="SqlDataSourceMagPartType"
                                                                                DataTextField="MagneticParticleType" DataValueField="MagneticParticleTypeID"
                                                                                EmptyMessage="Select a Mag Particle Type" EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceMagPartType" runat="server" SelectCommand="Select MagneticParticleTypeID, MagneticParticleType FROM tblSTIM_Certification_MagneticParticle"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label34" runat="server" Text="Current:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadComboBox ID="RadComboBoxMagPartCurrent" runat="server" DataSourceID="SqlDataSourceMagPartCurrent"
                                                                                DataTextField="MagCurrent" DataValueField="MagCurrentID" EmptyMessage="Select a Mag. Part. Current"
                                                                                EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceMagPartCurrent" runat="server" SelectCommand="Select MagCurrentID, MagCurrent from tblSTIM_Certification_Current"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label35" runat="server" Text="Amps:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxAmps" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label36" runat="server" Text="Method:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:TextBox ID="TextBoxMethod" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label37" runat="server" Text="Demagnetized:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <asp:TextBox ID="TextBoxDemag" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <br />
                                                            <telerik:RadButton ID="RadButtonStep6Next" runat="server" Text="Next" OnClick="RadButtonStep6Next_Click">
                                                                <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                            </telerik:RadButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                            <telerik:RadPanelItem Expanded="false" Text="Step 6: Liquid Penetrant" runat="server">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Value="Step7PanelItem">
                                        <ItemTemplate>
                                            <asp:Panel ID="Panel6" runat="server" BackColor="#BFCEE1">
                                                <table style="background-color: #BFCEE1;" align="center">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Panel ID="Panel5" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label33" runat="server" Text="Type:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="center">
                                                                            <telerik:RadComboBox ID="RadComboBoxLiquidPenType" runat="server" DataSourceID="SqlDataSourceLiquidPenType"
                                                                                DataTextField="NDELiquidPenetrant" DataValueField="NDELiquidPenetrantID" EmptyMessage="Select a Liquid Penetrant Type"
                                                                                EnableAutomaticLoadOnDemand="true">
                                                                            </telerik:RadComboBox>
                                                                            <asp:SqlDataSource ID="SqlDataSourceLiquidPenType" runat="server" SelectCommand="Select NDELiquidPenetrantID, NDELiquidPenetrant FROM tblSTIM_NDELiquidPenetrant"
                                                                                ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label34" runat="server" Text="Penetrant:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxPenetrant" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label35" runat="server" Text="Developer:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxDeveloper" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label36" runat="server" Text="Remover:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxRemover" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Panel ID="Panel7" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label38" runat="server" Text="Time:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextLiqPenMin" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label39" runat="server" Text="Time:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxLiqPenDevMin" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Label40" runat="server" Text="Time:" CssClass="Labels"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                            <telerik:RadNumericTextBox ID="RadNumericTextBoxLiqPenRemMin" runat="server">
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <br />
                                                            <telerik:RadButton ID="RadButtonStep7Next" runat="server" Text="Next" OnClick="RadButtonStep7Next_Click">
                                                                <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                                            </telerik:RadButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server" BackColor="#BFCEE1">
                <br />
                <asp:Panel ID="Panel3" runat="server" Width="100%">
                    <table>
                        <tr>
                            <td align="center">
                                <telerik:RadAsyncUpload ID="RadAsyncUpload2" runat="server" AllowedFileExtensions="pdf,jpeg,gif,jpg,png"
                                    MultipleFileSelection="Automatic" 
                                    AllowedMimeTypes="image/tiff,image/png,image/jpeg,image/gif"  >
                                </telerik:RadAsyncUpload>
                               <%-- <telerik:RadProgressArea ID="RadProgressArea1" runat="server">
                                </telerik:RadProgressArea> --%>
                              <%--  <telerik:RadUpload ID="RadUpload1" runat="server" Visible="false" InitialFileInputsCount="1" MaxFileSize="10000000" ControlObjectsVisibility="AddButton"
                                 MaxFileInputsCount="5"></telerik:RadUpload>--%>

                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <table>
                                    <tr>
                                        <td align="right">
                                            <br />
                                            <telerik:RadButton ID="RadButtonUpload" runat="server" Text="Upload" OnClick="RadButtonUpload_Click">
                                                <Icon PrimaryIconCssClass="rbUpload" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                            </telerik:RadButton>
                                        </td>
                                        <td align="left">
                                            <br />
                                            <telerik:RadButton ID="RadButtonGotoPrint" runat="server" Text="Next" OnClick="RadButtonGotoPrint_Click">
                                                <Icon PrimaryIconCssClass="rbNext" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView4" runat="server" BackColor="White" OnLoad="RadPageView4_Load">
                <table >
                    <tr>
                        <td colspan="2">
                            <telerik:RadSlider ID="RadSlider2" runat="server" TrackPosition="TopLeft" Value="0"
                                ItemType="Item" Width="450px" Height="40px" Skin="Windows7" OnClientValueChanged="UpdateVisibleSlide"
                                OnClientLoad="UpdateVisibleSlide" Visible="false">
                                <Items>
                                    <telerik:RadSliderItem Text="Certificate"></telerik:RadSliderItem>
                                    <telerik:RadSliderItem Text="Images"></telerik:RadSliderItem>
                                </Items>
                            </telerik:RadSlider>
                        </td>
                    </tr>
                </table>
                <div id="Printmeonly">
                    <center>
                        <asp:FormView ID="FormViewPadEyes" runat="server" DataSourceID="SqlDataSourcePadEyes"
                            OnLoad="FormViewPadEyes_Load">
                            <ItemTemplate>
                                <center>
                                    <div id="slide_00" class="slide">
                                        <asp:Panel ID="PanelPadeyes" runat="server" BackColor="White" Width="100%">
                                            <table width="100%">
                                                <tr>
                                                    <td style="font-size: larger" align="center">
                                                        CERTIFICATE OF NONDESTRUCTIVE EXAMINATION
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <table style="padding-right: 300px; width: 100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Image ID="Image2" runat="server" Width="210px" Height="100px" ImageUrl="~/Graphics/stim logo.jpg" />
                                                                                <br />
                                                                                <font size="2">WWW.STIMSERVICES.COM</font>
                                                                            </td>
                                                                            <td align="left" style="padding-right: 250px">
                                                                                <table style="padding-top: 50px;">
                                                                                    <tr>
                                                                                        <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                            3507 Captain Cade Rd.
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                            Broussard, LA 70518
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                            Bus: (337) 606-0165
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                            Fax: (337) 606-0167
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td align="left">
                                                                    <table>
                                                                        <tr>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <asp:Label ID="Label119" runat="server" Text="Cert No:" Font-Size="15px"></asp:Label>
                                                                            </td>
                                                                            <td align="center">
                                                                                <asp:Label ID="Label16" runat="server" Text='<%# Bind("CertificationNumber") %>'
                                                                                    Font-Size="15px"></asp:Label>
                                                                                <hr class="bigLine" style="height: 1px" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <asp:Label ID="Label121" runat="server" Text="Cert. Date:" Font-Size="15px"></asp:Label>
                                                                            </td>
                                                                            <td align="center" nowrap="nowrap" style="padding-top: 20px">
                                                                                <asp:Label ID="Label41" runat="server" Text='<%# Bind("CertificationDate", "{0:MM/dd/yyyy}")%>'
                                                                                    Font-Size="15px"></asp:Label>
                                                                                <hr class="bigLine" style="height: 1px" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <asp:Label ID="Label122" runat="server" Text="Specification No:" Font-Size="15px"></asp:Label>
                                                                            </td>
                                                                            <td align="center" style="padding-top: 20px">
                                                                                <asp:Label ID="Label42" runat="server" Text='<%# Bind("SpecificationNumber") %>'
                                                                                    Font-Size="15px"></asp:Label>
                                                                                <hr class="bigLine" style="height: 1px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <hr style="height: 4px; width: 100%; background-color: Black;" color="Black" class="bigLine" />
                                            <table>
                                                <tr>
                                                    <td align="center" style="font-size: x-large; font-weight: bold">
                                                        <asp:Label ID="Label47" runat="server" Text='<%# Bind("MethodOfInspection") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%">
                                                <tr>
                                                    <td align="left">
                                                        <table>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap">
                                                                    <asp:Label ID="Label46" runat="server" Text="Customer:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="LabelPrintCustomer" runat="server" Text='<%# Bind("CustomerName") %>'
                                                                        Font-Size="15px"></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap">
                                                                    <asp:Label ID="Label48" runat="server" Text=" Job No:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Label ID="LabelPrintJobNo" runat="server" Text='<%# Bind("JobNumber") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap">
                                                                    <asp:Label ID="Label49" runat="server" Text=" Job Location:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Label ID="LabelPrintJobLoc" runat="server" Text='<%# Bind("JobLocation") %>'
                                                                        Font-Size="15px"></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap">
                                                                    <asp:Label ID="Label50" runat="server" Text="Total Hours:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td align="center">
                                                                                <asp:Label ID="Label43" runat="server" Text='<%# Bind("TotalHours") %>' Font-Size="15px">  </asp:Label>
                                                                                <hr class="smallLine" style="height: 1px" />
                                                                            </td>
                                                                            <td align="right">
                                                                                &nbsp;&nbsp;
                                                                                <asp:Label ID="Label51" runat="server" Text="Mileage:" CssClass="PrintCertLabel"
                                                                                    Font-Size="15px"></asp:Label>
                                                                            </td>
                                                                            <td align="center">
                                                                                <asp:Label ID="Label45" runat="server" Text='<%# Bind("Mileage") %>' Font-Size="15px"></asp:Label>
                                                                                <hr class="smallLine" style="height: 1px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="left">
                                                        <table>
                                                            <tr>
                                                                <td align="right">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label52" runat="server" Text="Status:" CssClass="PrintCertLabel" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="LabelPrintStatus" Font-Bold="true" runat="server" Text='<%# Bind("RejectionStatus") %>'
                                                                        Font-Size="15px"></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px; width: 250px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label53" runat="server" Text="Date:" CssClass="PrintCertLabel" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="Label44" runat="server" Text='<%# Bind("JobDate", "{0:MM/dd/yyyy}")%>'
                                                                        Font-Size="15px"></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label54" runat="server" Text="PO No:" CssClass="PrintCertLabel" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="LabelPrintPO" runat="server" Font-Size="15px" Text='<%#(String.IsNullOrEmpty(Eval("PONumber").ToString()) ? "&nbsp;" : Eval("PONumber"))%>'></asp:Label>
                                                                    <hr class="bigLine" style="height: 1px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <hr style="height: 4px; width: 100%; background-color: Black;" color="Black" class="bigLine" />
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td align="left" nowrap="nowrap">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label55" runat="server" Text="Unit Number:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="left" nowrap="nowrap">
                                                                    <asp:Label ID="Label56" runat="server" Text='<%# Bind("ItemNumber") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" style="width: 200px; padding-right: 220px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" nowrap="nowrap">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label57" runat="server" Text="Description:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Label ID="Label58" runat="server" Text='<%# Bind("ItemDescription") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" style="width: 420px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" nowrap="nowrap">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="Label59" runat="server" Text="Testing unit:" CssClass="PrintCertLabel"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Label ID="Label60" runat="server" Text='<%# Bind("TestingMachine") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" style="width: 420px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <table style="color: Black; border-width: 1px; border-color: #666666; border-collapse: collapse;
                                                            font-size: 11px; border-style: solid; width: 430px">
                                                            <tr>
                                                                <th nowrap="nowrap" style="border-width: 1px; padding: 3px; border-style: solid;
                                                                    border-color: #666666; background-color: white">
                                                                    <asp:Label ID="Label71" runat="server" Text="EMPTY WT:" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </th>
                                                                <th nowrap="nowrap" style="border-width: 1px; padding: 3px; border-style: solid;
                                                                    border-color: #666666; background-color: white">
                                                                    <asp:Label ID="Label72" runat="server" Text="TESTED TO" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </th>
                                                                <th nowrap="nowrap" style="border-width: 1px; padding: 3px; border-style: solid;
                                                                    border-color: #666666; background-color: white">
                                                                    <asp:Label ID="Label73" runat="server" Text="MAX. UNIT CAPACITY" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </th>
                                                                <th nowrap="nowrap" style="border-width: 1px; padding: 3px; border-style: solid;
                                                                    border-color: #666666; background-color: white">
                                                                    <asp:Label ID="Label74" runat="server" Text="# OF PAD-EYES" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </th>
                                                                <th nowrap="nowrap" style="border-width: 1px; padding: 3px; border-style: solid;
                                                                    border-color: #666666; background-color: white">
                                                                    <asp:Label ID="Label75" runat="server" Text="2.5 x MAX CAPACITY" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #666666;">
                                                                    <asp:Label ID="Label76" runat="server" Text='<%# Bind("EmptyWeight") %>' Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #666666;">
                                                                    <asp:Label ID="Label77" runat="server" Text='<%# Bind("TestedToPressure") %>' Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #666666;">
                                                                    <asp:Label ID="Label78" runat="server" Text='<%# Bind("MaxUnitCapacity") %>' Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #666666;">
                                                                    <asp:Label ID="Label79" runat="server" Text='<%# Bind("NumberofLegsEyes") %>' Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #666666;">
                                                                    <asp:Label ID="Label80" runat="server" Text='<%# Bind("DoubleMaxUnitCapacity") %>'
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label61" runat="server" Text="INSPECTOR:" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="Label63" runat="server" Text='<%# Bind("Inspector") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label64" runat="server" Text="TESTED BY:" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="Label65" runat="server" Text='<%# Bind("Tester") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:Label ID="Label62" runat="server" Text="LEVEL:" CssClass="PrintCertLabel" Font-Bold="true"
                                                                        Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="Label66" runat="server" Text='<%# Bind("InspectorLevel") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:Label ID="Label67" runat="server" Text="WITNESS:" CssClass="PrintCertLabel"
                                                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="Label68" runat="server" Text='<%# Bind("Witness") %>' Font-Size="15px"></asp:Label>
                                                                    <hr class="mediumLine" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <hr style="height: 4px; width: 100%; background-color: Black;" color="Black" class="bigLine" />
                                            <table width="98%" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                border-collapse: collapse">
                                                <tr>
                                                    <th align="center" nowrap="nowrap" style="border-width: 1px; border-style: solid;
                                                        border-color: #666666; background-color: white">
                                                        <asp:Label ID="Label69" runat="server" Text="Material" CssClass="PrintCertLabel"
                                                            Font-Size="15px" Font-Bold="true"></asp:Label>
                                                    </th>
                                                    <th align="center" nowrap="nowrap" style="border-width: 1px; border-style: solid;
                                                        border-color: #666666; background-color: white">
                                                        <asp:Label ID="Label81" runat="server" Text="Scope of Examination" Font-Size="15px"
                                                            CssClass="PrintCertLabel" Font-Bold="true"></asp:Label>
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                        padding: 35px">
                                                        <asp:Label ID="Label70" runat="server" Font-Size="15px" Text='<%# Bind("Material") %>'
                                                            CssClass="PrintCertLabel" Font-Bold="true" Font-Underline="true"></asp:Label>
                                                    </td>
                                                    <td align="left" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                        padding: 35px">
                                                        <asp:Label ID="Label82" runat="server" Font-Size="15px" Text='<%# Bind("ScopeofExamination") %>'
                                                            CssClass="PrintCertLabel" Font-Bold="true" Font-Underline="true"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label83" runat="server" Font-Size="15px" Text="Technician: (es)" CssClass="PrintCertLabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label84" runat="server" Font-Size="15px" Text='<%# Bind("Tech") %>'
                                                                        CssClass="PrintCertLabel"></asp:Label>
                                                                    <hr class="mediumLine" style="width: 180px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label85" runat="server" Font-Size="15px" Text="Level: " CssClass="PrintCertLabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label86" runat="server" Font-Size="15px" Text='<%# Bind("TechLevel") %>'
                                                                        CssClass="PrintCertLabel"></asp:Label>
                                                                    <hr class="smallLine" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label87" runat="server" Font-Size="15px" Text="Assistant: (es)" CssClass="PrintCertLabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label88" runat="server" Font-Size="15px" Text='<%# Bind("Assistant") %>'
                                                                        CssClass="PrintCertLabel"></asp:Label>
                                                                    <hr class="mediumLine" style="width: 180px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label89" runat="server" Font-Size="15px" Text="Level:" CssClass="PrintCertLabel"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label90" runat="server" Font-Size="15px" Text='<%# Bind("AsstLevel") %>'
                                                                        CssClass="PrintCertLabel"></asp:Label>
                                                                    <hr class="smallLine" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table>
                                                <tr>
                                                    <td align="left" style='<%#(String.IsNullOrEmpty(Eval("MagneticParticleType").ToString()) ? "display:none": "padding-right: 100px;display:")%>'
                                                        runat="server">
                                                        <asp:Panel ID="PanelMagPart" runat="server" Visible='<%#!(String.IsNullOrEmpty(Eval("MagneticParticleType").ToString()))%>'>
                                                            <table align="left" width="400px" height="300px" style="border-width: 2px; border-style: solid;
                                                                border-color: #666666; border-collapse: collapse">
                                                                <tr>
                                                                    <th nowrap="nowrap" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                                        background-color: white">
                                                                        <asp:Label ID="Label91" runat="server" Text="MAGNETIC PARTICLE" Style="font-size: 14px;"
                                                                            Font-Bold="true"></asp:Label>
                                                                    </th>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                                        background-color: white">
                                                                        <table>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label ID="Label93" runat="server" Text="Test Type:" Font-Size="14px"></asp:Label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <asp:Label ID="Label95" runat="server" Text='<%# Bind("MagneticParticleType") %>'
                                                                                        Font-Size="14px"></asp:Label>
                                                                                    <hr class="mediumLine" style="width: 250px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label ID="Label97" runat="server" Text="Current:" Font-Size="14px"></asp:Label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <asp:Label ID="Label98" runat="server" Text='<%# Bind("CurrentPower") %>' Font-Size="14px"></asp:Label>
                                                                                    <hr class="mediumLine" style="width: 250px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label ID="Label99" runat="server" Text="Amps:" Font-Size="14px"></asp:Label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <asp:Label ID="Label100" runat="server" Text='<%# Bind("MagneticParticleAmps") %>'
                                                                                        Font-Size="14px"></asp:Label>
                                                                                    <hr class="mediumLine" style="width: 250px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label ID="Label101" runat="server" Text="Method:" Font-Size="14px"></asp:Label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <asp:Label ID="Label102" runat="server" Text='<%# Bind("MagneticParticleMethod") %>'
                                                                                        Font-Size="14px"></asp:Label>
                                                                                    <hr class="mediumLine" style="width: 250px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <asp:Label ID="Label103" runat="server" Text="DeMagnetized:" Font-Size="14px"></asp:Label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <asp:Label ID="Label104" runat="server" Text='<%# Bind("MagneticParticleDemagnetized") %>'
                                                                                        Font-Size="14px"></asp:Label>
                                                                                    <hr class="mediumLine" style="width: 250px" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                    <td style='<%#(String.IsNullOrEmpty(Eval("NDELiquidPenetrant").ToString()) ? "display:none": "display:;padding-right: 100px")%>'>
                                                        <asp:Panel ID="PanelLiquidPen" runat="server" Visible='<%#!(String.IsNullOrEmpty(Eval("NDELiquidPenetrant").ToString()))%>'>
                                                            <table align="left" width="20%" style="border-width: 2px; border-style: solid; border-color: #666666;
                                                                border-collapse: collapse">
                                                                <tr>
                                                                    <th nowrap="nowrap" style="border-width: 1px; border-style: solid; border-color: #666666;
                                                                        background-color: white">
                                                                        <asp:Label ID="Label92" runat="server" Text="LIQUID PENETRANT" Style="font-size: 12px;"
                                                                            Font-Bold="true"></asp:Label>
                                                                    </th>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" style="border-width: 1px; border-style: solid; border-color: #666666;">
                                                                        <table>
                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" nowrap="nowrap">
                                                                                                <asp:Label ID="Label94" runat="server" Text="Test Type" Font-Size="10px"></asp:Label>&nbsp;&nbsp;
                                                                                            </td>
                                                                                            <td align="left" style="padding-top: 20px">
                                                                                                <asp:Label ID="Label96" runat="server" Text='<%# Bind("NDELiquidPenetrant") %>' Font-Size="15px"></asp:Label>
                                                                                                <hr class="smallLine" style="width: 170px" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label105" runat="server" Text="Penetrant" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label107" runat="server" Text='<%# Bind("LiquidPenetrantDeveloperTime") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label110" runat="server" Text="Developer" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label111" runat="server" Text='<%# Bind("LiquidPenetrantRemoverTime") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label106" runat="server" Text="Remover" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label108" runat="server" Text='<%# Bind("LiquidPenetrantPenetrantMinute") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td align="right">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label109" runat="server" Text="Time" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label112" runat="server" Text='<%# Bind("LiquidPenetrantPenetrantMinute") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="Label117" runat="server" Text="Min" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label113" runat="server" Text="Time" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label114" runat="server" Text='<%# Bind("LiquidPenetrantDeveloperMinute") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="Label118" runat="server" Text="Min" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Label115" runat="server" Text="Time" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                            <td style="padding-top: 20px">
                                                                                                <asp:Label ID="Label116" runat="server" Text='<%# Bind("LiquidPenetrantRemoverMinute") %>'
                                                                                                    Font-Size="10px"></asp:Label>
                                                                                                <hr class="smallLine" width="30px" />
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="Label120" runat="server" Text="Min" Font-Size="10px"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                    <td align="left">
                                                        <telerik:RadListView ID="RadListViewMainImage" runat="server" DataSourceID="SqlDataSourceMainImage"
                                                            AllowPaging="false" Visible="true" ItemPlaceholderID="ImagesContainer">
                                                            <LayoutTemplate>
                                                                <div style="width: 80%; border: 1px">
                                                                    <asp:PlaceHolder ID="ImagesContainer" runat="server"></asp:PlaceHolder>
                                                                </div>
                                                            </LayoutTemplate>
                                                            <ItemTemplate>
                                                                <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" Visible="true" DataValue='<%#Eval("BinaryImage") %>'
                                                                    AutoAdjustImageControlSize="false" Width="400px" Height="300px" BorderWidth="2">
                                                                </telerik:RadBinaryImage>
                                                            </ItemTemplate>
                                                        </telerik:RadListView>
                                                        <asp:SqlDataSource ID="SqlDataSourceMainImage" runat="server" SelectCommand="Select BinaryImage From tblSTIM_ImageLibrary Where CertificationID = @CertificationID and ImageOrder = 1"
                                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="TextBoxCertID" Name="CertificationID" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <br />
                                            <table>
                                                <tr>
                                                    <td style="font-size: xx-small">
                                                        *Disclaimer: This certificate of non-destructive examination is for proof of work
                                                        completed only. We reserve the right to make verbiage changes necessary to the content
                                                        of this certificate listed herein for billing purposes.
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table width="80%" border="2" cellpadding="4px" style="border-collapse: collapse">
                                                <tr>
                                                    <td style="border: none">
                                                        <br />
                                                        <br />
                                                        <br />
                                                        <div class="horizontalRuleSign">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="border: none; page-break-after: always" align="center">
                                                        Technician Signature
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                    <br clear="all" style='mso-special-character: line-break; page-break-before: always'>
                                    <div id="slide_01" class="slide">
                                        <table width="100%">
                                            <tr>
                                                <td style="font-size: 20px; font-weight: bold" align="center">
                                                    Supporting Images for Certification #
                                                    <asp:Label ID="Label124" runat="server" Text='<%# Bind("CertificationNumber") %>'
                                                        Font-Size="20px"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <table style="padding-right: 300px; width: 100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Image ID="Image3" runat="server" Width="210px" Height="100px" ImageUrl="~/Graphics/stim logo.jpg" />
                                                                            <br />
                                                                            <font size="2">WWW.STIMSERVICES.COM</font>
                                                                        </td>
                                                                        <td align="left" style="padding-right: 250px">
                                                                            <table style="padding-top: 50px;">
                                                                                <tr>
                                                                                    <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                        3507 Captain Cade Rd.
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                        Broussard, LA 70518
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                        Bus: (337) 606-0165
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="font-size: x-small" align="left" nowrap="nowrap">
                                                                                        Fax: (337) 606-0167
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td align="left">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right" nowrap="nowrap">
                                                                            <asp:Label ID="Label125" runat="server" Text="Cert. Date:" Font-Size="15px"></asp:Label>
                                                                        </td>
                                                                        <td align="center" nowrap="nowrap" style="padding-top: 20px">
                                                                            <asp:Label ID="Label126" runat="server" Text='<%# Bind("CertificationDate", "{0:MM/dd/yyyy}")%>'
                                                                                Font-Size="15px"></asp:Label>
                                                                            <hr class="bigLine" style="height: 1px" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right" nowrap="nowrap">
                                                                            <asp:Label ID="Label127" runat="server" Text="Specification No:" Font-Size="15px"></asp:Label>
                                                                        </td>
                                                                        <td align="center" style="padding-top: 20px">
                                                                            <asp:Label ID="Label128" runat="server" Text='<%# Bind("SpecificationNumber") %>'
                                                                                Font-Size="15px"></asp:Label>
                                                                            <hr class="bigLine" style="height: 1px" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <hr style="height: 4px; width: 100%; background-color: Black;" color="Black" class="bigLine" />
                                        <br />
                                        <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSource1"
                                            AllowPaging="false" Visible="true" ItemPlaceholderID="ImagesContainer">
                                            <LayoutTemplate>
                                                <div style="width: 1000px;">
                                                    <asp:PlaceHolder ID="ImagesContainer" runat="server"></asp:PlaceHolder>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" Visible="true" DataValue='<%#Eval("BinaryImage") %>'
                                                    AutoAdjustImageControlSize="false" BorderWidth="2" Width="300px" Height="200px">
                                                </telerik:RadBinaryImage>
                                            </ItemTemplate>
                                        </telerik:RadListView>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="Select top 12 BinaryImage From tblSTIM_ImageLibrary Where CertificationID = @CertificationID and ImageOrder > 1"
                                            ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="TextBoxCertID" Name="CertificationID" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </center>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="SqlDataSourcePadEyes" runat="server" OnLoad="SqlDataSourcePadEyes_Load"
                            SelectCommand="sp_STIM_rptCertificationInspectionReport @whereClause" ConnectionString="<%$ ConnectionStrings:SSIRentConnectionString %>">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBoxwhereClause" Name="whereClause" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:TextBox ID="TextBoxwhereClause" runat="server" Visible="false"></asp:TextBox>
                    </center>
                </div>
                <table>
                    <tr>
                        <td colspan="2">
                            <telerik:RadSlider ID="RadSlider1" runat="server" TrackPosition="TopLeft" Value="0"
                                ItemType="Item" Width="450px" Height="40px" Skin="Windows7" OnClientValueChanged="UpdateVisibleSlide"
                                OnClientLoad="UpdateVisibleSlide" Visible="false">
                                <Items>
                                    <telerik:RadSliderItem Text="Certificate"></telerik:RadSliderItem>
                                    <telerik:RadSliderItem Text="Images"></telerik:RadSliderItem>
                                </Items>
                            </telerik:RadSlider>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadButton ID="RadButtonPrint" runat="server" Text="Print" OnClientClicked="CallPrint">
                                <Icon PrimaryIconCssClass="rbPrint" PrimaryIconLeft="4" PrimaryIconTop="6"></Icon>
                            </telerik:RadButton>
                              <telerik:RadButton ID="RadButtonCreateNew" runat="server" Text="New Cert" AutoPostBack="false" OnClientClicked="AddNew" >
                                <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                            </telerik:RadButton>
                           
                        </td>
                    </tr>
                </table>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
       
  
        <br />
    </center>
</asp:Content>
