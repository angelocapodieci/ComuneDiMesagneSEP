﻿<%@ Page Language="VB" MasterPageFile="~/MainPage.master" AutoEventWireup="false"
    CodeFile="GestioneProtocollazioneMassivaFatturePage.aspx.vb" Inherits="GestioneProtocollazioneMassivaFatturePage" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/UI/Protocollo/pages/user/VisualizzaFatturaUserControl.ascx" TagName="VisualizzaFatturaControl"
    TagPrefix="parsec" %>
<%--SPDX-License-Identifier: GPL-3.0-only--%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">

        var _backgroundElement = document.createElement("div");
        var overlay = document.createElement("div");


        var hideFatturaPanel = true;
        var hideErrorPanel = true;
        var hideDestinarioPanel = true;


        Sys.Application.add_init(function () {
            var manager = Sys.WebForms.PageRequestManager.getInstance();
            manager.add_beginRequest(OnBeginRequest);
            manager.add_endRequest(OnEndRequest);
        });


        function pageLoad() {

            $get("pageContent").appendChild(_backgroundElement);
            $get("pageContent").appendChild(overlay);

            if (hideFatturaPanel) {
                HideFatturaElettronicaPanel();
            } else {
                ShowFatturaElettronicaPanel();
            }

            if (hideErrorPanel) {
                HideErrorPanel();
            } else {
                ShowErrorPanel();
            }

            if (hideDestinarioPanel) {
                HideDestinatarioPanel();
            } else {
                ShowDestinatarioPanel();
            }

        }


        function OnBeginRequest(sender, args) {
            EnableUI(false);
        }

        function OnEndRequest(sender, args) {
            count = 2;
            var message = $get('<%= infoOperazioneHidden.ClientId %>').value;

            if (message !== '') {

                //VISUALIZZO IL MESSAGGIO

                ShowMessageBox(message);

                var intervallo = setInterval(function () {
                    count = count - 1;
                    if (count <= 0) {
                        HideMessageBox();
                        EnableUI(true);
                        clearInterval(intervallo);

                    }
                }, 1000);



                $get('<%= infoOperazioneHidden.ClientId %>').value = '';

            } else { EnableUI(true); }
        }


        function ShowMessageBox(message) {

            overlay.style.display = '';
            overlay.style.position = 'absolute';
            overlay.style.left = '0px';
            overlay.style.top = '0px';
            overlay.style.width = '100%';
            overlay.style.height = '100%';
            overlay.style.zIndex = 10000;
            overlay.style.backgroundColor = '#09718F';
            overlay.style.filter = "alpha(opacity=20)";
            overlay.style.opacity = "0.2";

            var messageBoxPanel = document.getElementById("messageBoxPanel");


            with (messageBoxPanel) {
                style.display = '';
            }

            var messageBox = document.getElementById("messageBox");

            with (messageBox) {
                style.width = '300px';
                style.height = '40px';
                style.backgroundColor = '#BFDBFF';
                style.border = 'solid #4892FF 2px';
                innerHTML = message;
                style.color = '#00156E';
                style.backgroundImage = 'url(/sep/Images/success.png)';
                style.backgroundPosition = '10px center';
                style.backgroundRepeat = 'no-repeat';
                style.padding = '15px 10px 15px 50px';
                style.margin = '15px 0px';

            }



        }


        function HideMessageBox() {
            try {
                var messageBoxPanel = document.getElementById("messageBoxPanel");
                messageBoxPanel.style.display = 'none';
                overlay.style.display = 'none';
            }
            catch (e) { }
        }


        function EnableUI(state) {
            if (!state) {
                _backgroundElement.style.display = '';
                _backgroundElement.style.position = 'absolute';
                _backgroundElement.style.left = '0px';
                _backgroundElement.style.top = '0px';

                _backgroundElement.style.width = '100%';
                _backgroundElement.style.height = '100%';

                _backgroundElement.style.zIndex = 10000;

                _backgroundElement.style.backgroundColor = '#09718F';
                _backgroundElement.style.filter = "alpha(opacity=20)";
                _backgroundElement.style.opacity = "0.2";
            }
            else {
                _backgroundElement.style.display = 'none';

            }
        }


        function HideFatturaElettronicaPanel() {

            var panel = document.getElementById("FatturaPanel");
            panel.style.display = "none";
            overlay.style.display = 'none';
        }


        function ShowFatturaElettronicaPanel() {


            var panel = document.getElementById("FatturaPanel");

            panel.style.display = '';
            panel.style.position = 'absolute';

            overlay.style.display = '';
            overlay.style.position = 'absolute';
            overlay.style.left = '0px';
            overlay.style.top = '0px';
            overlay.style.width = '100%';
            overlay.style.height = '100%';
            overlay.style.zIndex = 10000;
            overlay.style.backgroundColor = '#09718F';
            overlay.style.filter = "alpha(opacity=20)";
            overlay.style.opacity = "0.2";


            var shadow = document.getElementById("ShadowFatturaPanel");

            with (shadow) {
                style.msFilter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.filter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.boxShadow = "3px 3px 4px #333";
                style.mozBoxShadow = "3px 3px 4px #333";
                style.webkitBoxShadow = "3px 3px 4px #333";
            }

        }

        function HideErrorPanel() {
            var panel = document.getElementById("ErrorPanel");
            panel.style.display = "none";
            overlay.style.display = 'none';
            _backgroundElement.style.display = 'none';
        }

        function ShowErrorPanel() {
            overlay.style.display = '';
            var panel = document.getElementById("ErrorPanel");
            panel.style.display = '';
            panel.style.position = 'absolute';
            overlay.style.position = 'absolute';
            overlay.style.left = '0px';
            overlay.style.top = '0px';
            overlay.style.width = '100%';
            overlay.style.height = '100%';
            overlay.style.zIndex = 10000;
            overlay.style.backgroundColor = '#09718F';
            overlay.style.filter = "alpha(opacity=20)";
            overlay.style.opacity = "0.2";

            var shadow = document.getElementById("ErrorShadowPanel");

            with (shadow) {
                style.msFilter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.filter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.boxShadow = "3px 3px 4px #333";
                style.mozBoxShadow = "3px 3px 4px #333";
                style.webkitBoxShadow = "3px 3px 4px #333";
            }

        }

        function HideDestinatarioPanel() {
            var panel = document.getElementById("DestinatarioPanel");
            panel.style.display = "none";
            overlay.style.display = 'none';

        }

        function ShowDestinatarioPanel() {

            var panel = document.getElementById("DestinatarioPanel");
            panel.style.display = '';
            panel.style.position = 'absolute';

            overlay.style.display = '';
            overlay.style.position = 'absolute';
            overlay.style.left = '0px';
            overlay.style.top = '0px';
            overlay.style.width = '100%';
            overlay.style.height = '100%';
            overlay.style.zIndex = 10000;
            overlay.style.backgroundColor = '#09718F';
            overlay.style.filter = "alpha(opacity=20)";
            overlay.style.opacity = "0.2";

            var shadow = document.getElementById("ShadowDestinatarioPanel");

            with (shadow) {
                style.msFilter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.filter = "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#333333')";
                style.boxShadow = "3px 3px 4px #333";
                style.mozBoxShadow = "3px 3px 4px #333";
                style.webkitBoxShadow = "3px 3px 4px #333";
            }
        }


        function updating(sender, args) {
            var d = $get("progressBar");
            d.style.display = '';
            if (args.get_progressData() && args.get_progressData().OperationComplete == 'true') {
                args.set_cancel(true);
                d.style.display = 'none';
            }
        }


    </script>
    <asp:UpdateProgress runat="server" ID="UpdateProgress1" DisplayAfter="0">
        <ProgressTemplate>
            <div id="loadingOuter" style="position: absolute; width: 100%; text-align: center;
                top: 300px; z-index: 2000000">
                <table cellpadding="4" style="background-color: #4892FF; margin: 0 auto">
                    <tr>
                        <td>
                            <div id="loadingInner" style="width: 300px; text-align: center; background-color: #BFDBFF;
                                height: 60px">
                                <span style="color: #00156E">Attendere prego ... </span>
                                <br />
                                <br />
                                <img alt="" src="../../../../images/loading.gif" border="0">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="progressBar" style="position: absolute; width: 100%; text-align: center;
                top: 300px; z-index: 2000000">
                <div id="Div3" style="width: 310px; text-align: center; background-color: #BFDBFF;
                    margin: 0 auto">
                    <telerik:RadProgressArea OnClientProgressUpdating="updating" Skin="Office2007" ID="RadProgressArea1"
                        runat="server" ProgressIndicators="TotalProgress,RequestSize,TotalProgressPercent,TotalProgressBar"
                        HeaderText="Elaborazione in corso ...">
                        <Localization Total="Totale:" Uploaded="Completato:" />
                    </telerik:RadProgressArea>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="Pannello" runat="server">
        <ContentTemplate>
            <div id="pageContent">
                <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="all" runat="server"
                    DecorationZoneID="ZoneID1" Skin="Web20"></telerik:RadFormDecorator>
                <telerik:RadFormDecorator ID="RadFormDecorator2" DecoratedControls="all" runat="server"
                    DecorationZoneID="ZoneID2" Skin="Web20"></telerik:RadFormDecorator>
                <center>
                    <telerik:RadProgressManager ID="Radprogressmanager1" runat="server" Skin="Office2007" />
                    <table width="100%" cellpadding="5" cellspacing="5" border="0">
                        <tr>
                            <td>
                                <table class="ContainerWrapper" border="0" cellpadding="2" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td style="background-color: #BFDBFF; padding: 4px; border-bottom: 1px solid  #9ABBE8;
                                                        border-top: 1px solid  #9ABBE8; height: 25px">
                                                        &nbsp;<asp:Label ID="TitoloLabel" runat="server" Style="color: #00156E" Font-Bold="True"
                                                            Text="Filtro Fatture Elettroniche" />
                                                    </td>
                                                    <td align="center" style="width: 30px; background-color: #BFDBFF; border-bottom: 1px solid  #9ABBE8;
                                                        border-top: 1px solid  #9ABBE8;">
                                                        <asp:ImageButton ID="FiltraImageButton" runat="server" ImageUrl="~/images//search.png"
                                                            ToolTip="Effettua la ricerca con i filtri impostati" Style="border: 0" ImageAlign="AbsMiddle" />
                                                    </td>
                                                    <td align="center" style="width: 30px; background-color: #BFDBFF; border-bottom: 1px solid  #9ABBE8;
                                                        border-top: 1px solid  #9ABBE8;">
                                                        <asp:ImageButton ID="AnnullaFiltroImageButton" Style="border: 0" runat="server" ImageUrl="~/images//cancelSearch.png"
                                                            ToolTip="Annulla i filtri impostati" ImageAlign="AbsMiddle" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ContainerMargin">
                                            <table class="Container" cellpadding="0" cellspacing="4" width="100%" border="0">
                                                <tr>
                                                    <td align="center" style="height: 50px">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 90px">
                                                                    <asp:Label ID="DataInvioInizioLabel" runat="server" CssClass="Etichetta" Text="Ricevuta da" />
                                                                </td>
                                                                <td style="width: 125px">
                                                                    <telerik:RadDatePicker ID="DataInvioInizioTextBox" Skin="Office2007" Width="110px"
                                                                        runat="server" MinDate="1753-01-01" ToolTip="Data inizio ricezione fattura">
                                                                        <Calendar>
                                                                            <SpecialDays>
                                                                                <telerik:RadCalendarDay Repeatable="Today" Date="" ItemStyle-CssClass="rcToday" />
                                                                            </SpecialDays>
                                                                        </Calendar>
                                                                        <DatePopupButton ToolTip="Apri il calendario." />
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                                <td style="width: 20px">
                                                                    <asp:Label ID="DataInvioFineLabel" runat="server" CssClass="Etichetta" Text="a" />
                                                                </td>
                                                                <td>
                                                                    <telerik:RadDatePicker ID="DataInvioFineTextBox" Skin="Office2007" Width="110px"
                                                                        runat="server" MinDate="1753-01-01" ToolTip="Data fine ricezione fattura">
                                                                        <Calendar>
                                                                            <SpecialDays>
                                                                                <telerik:RadCalendarDay Repeatable="Today" Date="" ItemStyle-CssClass="rcToday" />
                                                                            </SpecialDays>
                                                                        </Calendar>
                                                                        <DatePopupButton ToolTip="Apri il calendario." />
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="width: 100%; background-color: #BFDBFF; border: 1px solid #5D8CC9">
                                                <tr>
                                                    <td>
                                                        <table style="width: 100%; background-color: #BFDBFF">
                                                            <tr>
                                                                <td>
                                                                    &nbsp;<asp:Label ID="TitoloElencoFattureLabel" runat="server" Font-Bold="True" Style="color: #00156E;
                                                                        background-color: #BFDBFF" Text="Elenco Fatture Elettroniche" />
                                                                </td>
                                                                <td style="width: 550px">
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td style="width: 80px">
                                                                                <asp:Label ID="ResponsabileLabel" runat="server" CssClass="Etichetta" Text="Destinatario" />
                                                                            </td>
                                                                            <td style="width: 300px">
                                                                                <span style="border-color: #abc1de; background: #fff; color: #000; font: 12px 'segoe ui',arial,sans-serif;
                                                                                    border-width: 1px; border-style: solid; padding: 2px 1px 0px; width: 390px; height: 19px">
                                                                                    <asp:Label ID="DestinatarioTextBox" Style="color: #000; font: 12px 'segoe ui',arial,sans-serif;"
                                                                                        runat="server" Width="290px" ToolTip="Nominativo del destinatario">&nbsp;</asp:Label>
                                                                                </span>
                                                                            </td>
                                                                            <td style="width: 25px; text-align: center">
                                                                                <asp:ImageButton ID="TrovaDestinatarioImageButton" runat="server" ImageUrl="~/images//knob-search16.png"
                                                                                    ToolTip="Seleziona Destinatario..." ImageAlign="AbsMiddle" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="EliminaDestinatarioImageButton" runat="server" ImageUrl="~/images//RecycleEmpty.png"
                                                                                    ToolTip="Cancella Destinatario" ImageAlign="AbsMiddle" />
                                                                                <asp:ImageButton ID="AggiornaDestinatarioImageButton" runat="server" ImageUrl="~/images//knob-search16.png"
                                                                                    Style="display: none; width: 0px" />
                                                                                <telerik:RadTextBox ID="IdDestinatarioTextBox" runat="server" Skin="Office2007" Style="display: none;
                                                                                    width: 0px" />
                                                                                <telerik:RadTextBox ID="CodiceDestinatarioTextBox" runat="server" Skin="Office2007"
                                                                                    Width="0px" Style="display: none" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td align="center" style="width: 40px">
                                                                    <asp:ImageButton ID="ProtocollaFattureSelezionateImageButton" Style="border: 0" runat="server"
                                                                        ImageUrl="~/images//ExportSelected32.png" ToolTip="Protocolla tutte le fatture elettroniche selezionate"
                                                                        ImageAlign="AbsMiddle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="ZoneID2" style="overflow: auto; height: 610px; width: 100%; background-color: #FFFFFF;
                                                            border: 0px solid #5D8CC9;">
                                                            <telerik:RadGrid ID="FattureElettronicheGridView" runat="server" AllowPaging="False"
                                                                AutoGenerateColumns="False" AllowFilteringByColumn="True" CellSpacing="0" GridLines="None"
                                                                Skin="Office2007" Width="99.8%" AllowSorting="True" Culture="it-IT" AllowMultiRowSelection="True">
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                                                                </ClientSettings>
                                                                <MasterTableView DataKeyNames="Id" TableLayout="Fixed">
                                                                    <Columns>
                                                                        <telerik:GridClientSelectColumn UniqueName="SelectCheckBox" HeaderStyle-HorizontalAlign="Center"
                                                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" ItemStyle-Width="30px">
                                                                        </telerik:GridClientSelectColumn>
                                                                        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column"
                                                                            HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id" Visible="False" />
                                                                        <telerik:GridTemplateColumn AndCurrentFilterFunction="Contains" ItemStyle-Width="190px"
                                                                            HeaderStyle-Width="190px" AutoPostBackOnFilter="True" DataField="DenominazioneFornitore"
                                                                            FilterControlAltText="Filter DenominazioneFornitore column" FilterControlWidth="100%"
                                                                            HeaderText="Fornitore" ShowFilterIcon="False" SortExpression="DenominazioneFornitore"
                                                                            UniqueName="DenominazioneFornitore" HeaderTooltip="Fornitore">
                                                                            <ItemTemplate>
                                                                                <div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 190px;
                                                                                    border: 0px solid red" title='<%# Replace(Eval("DenominazioneFornitore"), "'", "&#039;")%>'>
                                                                                    <%# Eval("DenominazioneFornitore")%>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn AndCurrentFilterFunction="Contains" ItemStyle-Width="190px"
                                                                            HeaderStyle-Width="190px" AutoPostBackOnFilter="True" DataField="DenominazioneDestinatario"
                                                                            FilterControlAltText="Filter DenominazioneDestinatario column" FilterControlWidth="100%"
                                                                            HeaderText="Destinatario" ShowFilterIcon="False" SortExpression="DenominazioneDestinatario"
                                                                            UniqueName="DenominazioneDestinatario" HeaderTooltip="Destinatario">
                                                                            <ItemTemplate>
                                                                                <div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 190px;
                                                                                    border: 0px solid red" title='<%# Replace(Eval("DenominazioneDestinatario"), "'", "&#039;")%>'>
                                                                                    <%# Eval("DenominazioneDestinatario")%>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridBoundColumn DataField="IdentificativoSdI" AutoPostBackOnFilter="True"
                                                                            ItemStyle-Width="85px" HeaderStyle-Width="85px" FilterControlAltText="Filter IdentificativoSdI column"
                                                                            HeaderText="Ident. SdI" SortExpression="IdentificativoSdI" UniqueName="IdentificativoSdI"
                                                                            ShowFilterIcon="False" FilterControlWidth="100%" HeaderTooltip="Identificativo SdI">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridTemplateColumn AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="True"
                                                                            DataField="Oggetto" FilterControlAltText="Filter Oggetto column" FilterControlWidth="100%"
                                                                            HeaderText="Estremi Fattura" ShowFilterIcon="False" SortExpression="Oggetto"
                                                                            UniqueName="Oggetto" HeaderTooltip="Estremi della Fattura">
                                                                            <ItemTemplate>
                                                                                <div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%;
                                                                                    border: 0px solid red" title='<%# Replace(Eval("Oggetto"), "'", "&#039;")%>'>
                                                                                    <%# Eval("Oggetto")%>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridBoundColumn DataField="PartitaIvaFornitore" FilterControlAltText="Filter PartitaIvaFornitore column"
                                                                            HeaderText="P. IVA" SortExpression="PartitaIvaFornitore" UniqueName="PartitaIvaFornitore"
                                                                            AutoPostBackOnFilter="True" ShowFilterIcon="False" FilterControlWidth="100%"
                                                                            ItemStyle-Width="80px" HeaderStyle-Width="80px" HeaderTooltip="Partita IVA">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="MessaggioSdI.Nomefile" FilterControlAltText="Filter MessaggioSdI.Nomefile column"
                                                                            HeaderText="Fattura" ShowFilterIcon="False" SortExpression="MessaggioSdI.Nomefile"
                                                                            UniqueName="MessaggioSdI.Nomefile" AllowFiltering="False" Visible="False">
                                                                            <HeaderStyle Width="200px" />
                                                                            <ItemStyle Width="200px" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="MessaggioSdI.PercorsoRelativo" FilterControlAltText="Filter MessaggioSdI.PercorsoRelativo column"
                                                                            HeaderText="PercorsoRelativo" ShowFilterIcon="False" SortExpression="MessaggioSdI.PercorsoRelativo"
                                                                            UniqueName="MessaggioSdI.PercorsoRelativo" Visible="False">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="VersioneFattura" FilterControlAltText="Filter VersioneFattura column"
                                                                            HeaderText="VersioneFattura" ShowFilterIcon="False" SortExpression="VersioneFattura"
                                                                            UniqueName="VersioneFattura" Visible="False">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn AllowFiltering="False" DataField="MessaggioSdI.DataRicezioneInvio"
                                                                            DataType="System.DateTime" FilterControlAltText="Filter MessaggioSdI.DataRicezioneInvio column"
                                                                            HeaderText="Ricezione" ShowFilterIcon="False" SortExpression="MessaggioSdI.DataRicezioneInvio"
                                                                            UniqueName="MessaggioSdI.DataRicezioneInvio" DataFormatString="{0:dd/MM/yyyy}"
                                                                            HeaderTooltip="Data di ricezione della Fattura" ItemStyle-Width="90px" HeaderStyle-Width="90px">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridButtonColumn ItemStyle-Width="30px" HeaderStyle-Width="30px" ButtonType="ImageButton"
                                                                            CommandName="Anteprima" FilterControlAltText="Filter Anteprima column" ImageUrl="~/images/knob-search16.png"
                                                                            UniqueName="Anteprima" Text="Anteprima Fattura" HeaderTooltip="Anteprima Fattura">
                                                                        </telerik:GridButtonColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="background-color: #BFDBFF; padding: 4px; border-bottom: 0px solid  #9ABBE8;
                                border-top: 1px solid  #9ABBE8; height: 25px">
                            </td>
                        </tr>
                    </table>
                </center>
                <div id="messageBoxPanel" style="position: absolute; width: 100%; text-align: center;
                    z-index: 2000000; display: none; top: 300px">
                    <div id="messageBox" style="width: 300px; height: 40; text-align: center; background-color: #BFDBFF;
                        margin: 0 auto;">
                    </div>
                </div>
                <div id="FatturaPanel" style="position: absolute; width: 100%; text-align: center;
                    z-index: 2000000; display: none; top: 0px">
                    <div id="ShadowFatturaPanel" style="width: 800px; text-align: center; background-color: #BFDBFF;
                        margin: 0 auto">
                        <parsec:VisualizzaFatturaControl runat="server" ID="VisualizzaFatturaControl" />
                    </div>
                </div>
                <div id="ErrorPanel" style="position: absolute; width: 100%; text-align: center;
                    z-index: 2000000; display: none; top: 50px">
                    <div id="ErrorShadowPanel" style="width: 600px; text-align: center; background-color: #BFDBFF;
                        margin: 0 auto">
                        <table width="600px" cellpadding="5" cellspacing="5" border="0">
                            <tr>
                                <td>
                                    <table class="ContainerWrapper" border="0" cellpadding="2" cellspacing="0" width="100%">
                                        <%--  HEADER--%>
                                        <tr>
                                            <td style="background-color: #BFDBFF; padding: 0px; border-bottom: 0px solid  #9ABBE8;
                                                border-top: 0px solid  #9ABBE8; height: 25px">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            &nbsp;<asp:Label ID="TitoloPannelloUploadLabel" runat="server" CssClass="Etichetta"
                                                                Font-Bold="True" Style="width: 500px; color: #00156E; background-color: #BFDBFF"
                                                                Text="Errore" />
                                                        </td>
                                                        <td align="right">
                                                            <img alt="Chiudi" src="../../../../images/Close.png" style="border: 0px" onclick="HideErrorPanel();hideErrorPanel=true;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%-- BODY--%>
                                        <tr>
                                            <td class="ContainerMargin">
                                                <table class="Container" cellpadding="0" cellspacing="4" width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <div id="pannelloEmail" runat="server" style="overflow: auto; height: 300px; width: 600px;
                                                                border: 0px solid #5D8CC9; background-color: #FFFFFF">
                                                                <asp:Literal ID="contenutoMessaggio" runat="server"> </asp:Literal>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%-- FOOTER--%>
                                        <tr>
                                            <td align="center" style="background-color: #BFDBFF; padding: 4px; border-bottom: 0px solid  #9ABBE8;
                                                border-top: 1px solid  #9ABBE8; height: 25px">
                                                &nbsp;
                                                <telerik:RadButton ID="ChiudiErrorPanelButton" runat="server" Text="Ok" Width="90px"
                                                    Skin="Office2007" ToolTip="Chiudi">
                                                    <Icon PrimaryIconUrl="../../../../images/cancel.png" PrimaryIconLeft="5px" />
                                                </telerik:RadButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <table style="width: 100%; border: 1px solid #9ABBE8; text-align: center">
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="infoOperazioneHidden" runat="server" />
            </div>
            <div id="DestinatarioPanel" style="position: absolute; width: 100%; text-align: center;
                z-index: 2000000; display: none; top: 300px">
                <div id="ShadowDestinatarioPanel" style="width: 600px; text-align: center; background-color: #BFDBFF;
                    margin: 0 auto">
                    <table width="600px" cellpadding="5" cellspacing="5" border="0">
                        <tr>
                            <td>
                                <table class="ContainerWrapper" border="0" cellpadding="2" cellspacing="0" width="100%">
                                    <%--  HEADER--%>
                                    <tr>
                                        <td style="background-color: #BFDBFF; padding: 0px; border-bottom: 1px solid  #9ABBE8;
                                            border-top: 1px solid  #9ABBE8; height: 25px">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="TitoloRicercaLabel" runat="server" Style="color: #00156E" Font-Bold="True"
                                                            Text="Seleziona Destinatario" CssClass="Etichetta" />
                                                    </td>
                                                    <td align="right">
                                                        <img alt="Chiudi" src="../../../../images/Close.png" style="border: 0px" onclick="document.getElementById('<%= Me.ChiudiRicercaImageButton.ClientID %>').click();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%-- BODY--%>
                                    <tr>
                                        <td class="ContainerMargin">
                                            <table class="Container" cellpadding="0" cellspacing="4" width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <div style="overflow: auto; height: 100px; width: 100%; background-color: #DFE8F6;
                                                            border: 0px solid #5D8CC9;">
                                                            <table style="width: 100%">
                                                                <tr style="height: 25px">
                                                                    <td style="width: 120px">
                                                                        <asp:Label ID="TipologiaDocumentoFiltroLabel" runat="server" CssClass="Etichetta"
                                                                            Text="Documento" />
                                                                    </td>
                                                                    <td style="padding-left: 1px; padding-right: 1px">
                                                                        <telerik:RadComboBox ID="TipologieDocumentoFiltroComboBox" runat="server" EmptyMessage="- Seleziona Tipologia -"
                                                                            MaxHeight="150px" Skin="Office2007" Width="340px" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 120px">
                                                                        <asp:Label ID="DescrizioneFiltroLabel" runat="server" CssClass="Etichetta" Text="Descrizione" />
                                                                    </td>
                                                                    <td style="padding-left: 1px; padding-right: 1px">
                                                                        <telerik:RadTextBox ToolTip="Descrizione del modello" ID="DescrizioneFiltroTextBox"
                                                                            runat="server" Skin="Office2007" Width="340px" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 120px">
                                                                        <asp:Label ID="StatoLabel" runat="server" CssClass="Etichetta" Text="Stato" />
                                                                    </td>
                                                                    <td style="padding-left: 1px; padding-right: 1px">
                                                                        <telerik:RadComboBox ID="StatoFiltroComboBox" runat="server" AutoPostBack="true"
                                                                            EmptyMessage="- Seleziona Stato -" MaxHeight="150px" Skin="Office2007" Width="340px" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%-- FOOTER--%>
                                    <tr>
                                        <td align="center" style="background-color: #BFDBFF; padding: 4px; border-bottom: 0px solid  #9ABBE8;
                                            border-top: 1px solid  #9ABBE8; height: 25px">
                                            <telerik:RadButton ID="SalvaButton" runat="server" Text="Ok" Width="90px" Skin="Office2007"
                                                ToolTip="Effettua la ricerca con i filtri impostati">
                                                <Icon PrimaryIconUrl="../../../../images/check16.png" PrimaryIconLeft="5px" />
                                            </telerik:RadButton>
                                            &nbsp;
                                            <telerik:RadButton ID="ChiudiRicercaImageButton" runat="server" Text="Chiudi" Width="100px"
                                                Skin="Office2007" ToolTip="Chiudi la finestra">
                                                <Icon PrimaryIconUrl="../../../../images/cancel.png" PrimaryIconLeft="5px" />
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
