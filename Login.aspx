<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<head runat="server">
    <title>Web Applications</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-2.2.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

      <link href="css/Login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="" Transparency="30">
                <div class="loading">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Graphics/loading_imagewithword.gif"
                        AlternateText="loading"></asp:Image>
                </div>
            </telerik:RadAjaxLoadingPanel>
        <div class="container-fluid">
                <div class="col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 text-center">
                    <asp:Login ID="Login2" runat="server" EnableViewState="true" OnAuthenticate="OnAuthenticate" RenderOuterTable="false">
                        <LayoutTemplate>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="LoginButton">
                                
                                    <div class="card card-container">
                                        <img src="Graphics/Logo2.png" class="profile-img-card" alt="supreme" />

                                        <%--<p id="profile-name" class="profile-name-card">&nbsp;</p>--%>
                                        <div class="form-signin">
                                            <div class="input-group input-group-lg">
                                                <asp:TextBox ID="UserName" class="form-control input-lg" runat="server" placeholder="User Name" required="true"></asp:TextBox>
                                                <span class="input-group-addon input-lg"><i class="fa fa-user"></i></span>
                                            </div>
                                            <br />
                                                <div class="input-group">
                                                     <asp:TextBox ID="Password" TextMode="Password" class="form-control input-lg" runat="server"
                                                          placeholder="Password" required="true" MaxLength="9"></asp:TextBox>
                                                       <span class="input-group-addon input-lg"><i class="fa fa-lock"></i></span>
                                                </div>
                                                <br />
                                                <div style="color: red">
                                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                </div>
                                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" ValidationGroup="Login1"
                                                    CssClass="btn btn-lg btn-success"></asp:Button>
                                            </div>
                                            <br />
                                            <button type="button" class="btn-link" data-toggle="modal" data-target="#InfoModal">Need Help Signing In?</button>
                                        </div>

                                   
                            </asp:Panel>
                            </div>
                        </LayoutTemplate>
                    </asp:Login>
                </div>
            </div>
       
    </form>
    
</body>

