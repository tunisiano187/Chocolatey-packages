// ==UserScript==
// @name            WME Send to Slack (Dev)
// @name:fr         WME Send to Slack (Dev)
// @namespace       https://gitlab.com/WMEScripts
// @description     Script to send unlock/closures/Validations requests to slack
// @description:fr  Ce script vous permettant d'envoyer vos demandes de délock/fermeture et de validation directement sur slack
// @version         2019.09.25.06
// @include 	    /^https:\/\/(www|beta)\.waze\.com\/(?!user\/)(.{2,6}\/)?editor.*$/
// @exclude         https://www.waze.com/user/*editor/*
// @exclude         https://www.waze.com/*/user/*editor/*
// @author          Tunisiano18
// @license         MIT/BSD/X11
// @compatible chrome
// @compatible firefox
// @compatible opera
// @require         https://greasyfork.org/scripts/24851-wazewrap/code/WazeWrap.js
// @require         https://gitlab.com/WMEScripts/wme-send-to-slack-public/raw/master/WMESTSData.user.js
// @supportURL      https://gitlab.com/WMEScripts/WME-send-to-slack-public/issues
// @contributionURL http://ko-fi.com/tunisiano
// @grant           GM_info
// ==/UserScript==

// Updates informations
var UpdateNotes = "Check parameters and log them + Waiting for WazeWrap";

// Var declaration
var ScriptName = GM_info.script.name;
var ScriptVersion = GM_info.script.version;
var segmentcount = 0;
var actionsloaded = 0;
var neededparams = {
    WMESTSCountry: ""
};

// Icons in variables
var iconopacity = "0.7";
var iconheight = "25px";
var Downlockicon = '<img id="slackPermalink" class="Downlock" title="Ask for downlock" style="opacity:' + iconopacity + ';" src="data:image/png;base64,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" height="' + iconheight + ';"/>';
var Relockicon = '<img id="slackPermalink" class="Lock" title="Ask for lock" style="opacity:' + iconopacity + ';" src="data:image/png;base64,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" height="' + iconheight + ';"/>';
var closureicon = '<img id="slackPermalink" class="Closure" title="Ask for a closure" style="opacity:' + iconopacity + ';" src="data:image/png;base64,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" height="' + iconheight + ';"/>';
var openicon = '<img id="slackPermalink" class="Open" title="Ask for openning a segment" style="opacity:' + iconopacity + ';" src="data:image/png;base64,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" height="' + iconheight + ';"/>';

var validationicon = '<img id="slackPermalink" class="Validation" title="Ask for validation" style="opacity:' + iconopacity + ';" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAABACAYAAABGHBTIAAAAAXNSR0IArs4c6QAAAVlpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KTMInWQAABftJREFUaAXtWl1MXEUUvrQs0OUuRZbVhS0FAuJitWuKQIIaQmoira2aJjZpfKgt1viCRq3hwSZuDGpqNCnWFzWm+KK+aNXW1hfbqKm1qETqD2pq0pak0NJtcGkpCAX3wwyZHeb37hr3mr0vM3POnDPz3e/emTPnXsvKXtk7kL0D2TvgojuQ46K5ak81Gn3US3eORt+cIO3/DeAt7WtXXxi92FGwxLpz2h9cQwCi9MRG+ov8pdve++zzk7m0wo11AI3HLu6LWblrlgaC1jQHBG6A7Z1sTahOLuHoXSO69fY71iWADrCM0gCuXpmwQqEV1iNdT7wLuWsZBrMJsIdocLz6skKvleeze5ubN8Wgdy3DMyWFe3gAaRlhd+vmu3cTuSsBg90/L021ERCiEuyGQmV9LS0bfyV9XAkYqzEBICrBrq+oyJrOvyFK93HdttS97f6KL4cnz9IgRPWmpsa+7ue7m2m96xje33/6QRoAry5iF31dBRgRlL8s+CoPJCurD9/Ut/vZzsOs3FWAD+w/8RgLgG2D3evLglZxwP8Bq0PbVYB12V1RHrJ2dj75sqsB79jU2skDwMrAbkVNZRcrJ23XMHxuaOxhMmlRicdZxi7sXBFaImae9ttJJyAeaAQaMnZh4wqGV+Zc7uYBpGVgF4eEy7HB12k5W894hk3YXXXbLV2JxWrhsM+CRTvjGTZh966myrd5IGlZRjNsyi45AtIA2XpGM5xudgE+Yxk2YZc+4LOMsu2MZThc53+GnSzbJivz9i2tO1mdqJ2RgE0O+Cbs4iZoPdKYgO2dae3/Y8wDo7889uCP3x1bdBKBLh3XfPrm0pTUFditrauzwO4be3qkfWmlEDBAIrOQSH0+juxXbCLXSgTvC7YrGyP9n3470LAgSFMF48Y00zem7GKKix5pnDnXNkR6kP4EWBEOpEZ1A3qRD57cJDln8u6SsZIAI33y9TdnrsiAEkOUZyYKXqPbqdZN3l1EVTr7LjunJMDHfzr9EdtB1U4nyybs6kRVvLknAeZ1UMnAMvvxSmXD02Pf1U29OmUX4yYBLq8o7uVNRiXTSb2ofJhEVaoTkWysJMBvffjFXnxpkxnwdEi9pMLyP1FV8hc/3jg474Jd+vMnr59MlgQYHc/O2btkBiLdVwdOvCTSqeS67NaH65XnXdVYiwAjoHDCMlZ2rLKqAVm9DrsIMkiuKhV2MfYiwBA6ZVlnlYV/+tJhF/1VuSrap6zOBeyUZayyYEw2IK0zZZe2dVrnAoYz/CLgxKkuY/Ct0xcLFb4iiPLMpnMUAsb/ENdGR4wjKYScDZHIU6qJoI/syz3s8e7yvgCqfMv0QsAwaltd9YrMWKTDNoUwVaTX/UZE2OV9IxL5VsmlgHft+3goNjzytMoJTz8wNfcOTw6ZzhZGDvfs912RT135UlXH4fPnj4evs++b9dplqr60furqtWpvcbDvwrmhU7QczA/NFrxPy3h1T57HKg2V9/a8+Jyjp4znEzIpw8TI6TZVVmofYiMwGfNkPMKuk+Mf8SEqtQBjm1pekn9U5EQm//n3kYNEj21IdUAgQUYqBwQyHq/UAgzDSH7OVp4DlYzem/+LbYidn/IdJgZHfvgtXlxoj3t99j1Eplv6vHkPVS23S+ZKgw/IbMBuVXW1tSxQu+PYkcNJ777MzkRn/FPLvY2R71X7p8kESF+AxTZUHQ73JpJyjoIe4ktWaj/SxInTCIzYy0qchv5NsBjbGDAisErv5KLkHhhyesEWKdeCQM16pz507YwBwzESBeyqjcfRyQWwOPphVU5nRCWaiyPAcLaqLrhB5FRXTt7bdB4OVGMbL1q0w/mkeSJ/Tct06wQs7285XR9O+qUEGAMimEBEpTs4gOLCY7y+vf1gx/aOjbq26eiXMmBMggZNmKMnR0BCBqDIXuDnk3SdcemxVPW0AMYgeLyR4pmdyW8bj8fnx6XB41xLgCLNmmpuSgVMpE8bYDJA1wt7142NntqMdqDId/NofPyXG2uqBlsaaj+h/1sm/bNl9g5k70D2Dpjcgb8B3gQeUjG7gl4AAAAASUVORK5CYII=" height="20px;"/>';

// Check if reset requested
if(window.location.hash == ("#reset-WME-STS")) {
    localStorage.removeItem('WMESTSBEChanel');
    alert("Language resetted");
}

// Initialization
function init(e) {
    log("Load");
    if (typeof W === 'undefined' || typeof W.map === 'undefined' || typeof W.prefs === 'undefined' || typeof W.app.modeController === 'undefined' || document.getElementById('edit-panel') === null) {
        setTimeout(init, 800);
        log("Map is still loading so we'll wait");
        return;
    }
    log('chargé');
    CheckNeededParams();
    // On change, check for changes in the edit-panel
    var WMESTSObserver = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            // Mutation is a NodeList and doesn't support forEach like an array
            for (var i = 0; i < mutation.addedNodes.length; i++) {
                var addedNode = mutation.addedNodes[i];

                // Only fire up if it's a node
                if (addedNode.nodeType === Node.ELEMENT_NODE) {
                    var locklevelDiv = addedNode.querySelector('div.form-control.lock-level-selector.waze-radio-container');
                    var closureslistDiv = addedNode.querySelector('div.closures-list');

                    if (locklevelDiv) {
                        log('Lock icons added');
                        $( "#WMESTSlock" ).remove();
                        $('div.form-control.lock-level-selector.waze-radio-container').after('<div id="WMESTSlock">' + Downlockicon + '&nbsp;' + Relockicon + '</div>');
                        //WMESTS.makeEditsSigns(locklevelDiv);
                        $( "#WMESTSvalidation" ).remove();
                        $('div.selection.selection-icon').append('<span id="WMESTSvalidation">' + validationicon + '</div>');
                        log('Validation icon added');
                        Loadactions();
                    }
                    if (closureslistDiv) {
                        log('Closure icons added');
                        //WMESTS.makeClosureSigns(closureslistDiv);
                        $( "#WMESTSclosures" ).remove();
                        if(W.layerSwitcherController.state.attributes.ITEM_CLOSURES === true) {
                            $('.closures-list').before('<div id="WMESTSclosures">' + closureicon + '&nbsp;' + openicon + '</div>');
                        }
                        Loadactions();
                    }
                }
            }
        });
    });
    WMESTSObserver.observe(document.getElementById('edit-panel'), { childList: true, subtree: true });
    setTimeout(VersionCheck(),2000);
    $('#WSTSFS-Container').css('display', 'block');
}

// Functions used by the Script

function Loadactions() {
    if(actionsloaded!=1){
        $(document).on("click", "img#slackPermalink", function () {
            var iconaction = $(this).attr('class');
            alert('click on ' + iconaction);
        });
        actionsloaded=1;
    }
}

function log(message) { // Thanks to Glodenox but enhanced
  if (typeof message === 'string') {
    console.log('%c' + ScriptName + ' : %c' + message, 'color:black', 'color:#d97e00');
  } else {
    console.log('%c' + ScriptName + ' :', 'color:black', message);
  }
}

function getPermalinkCleaned(text) {
    text = "https://www.waze.com/editor?env=row&";
    var selectedindex="";
    var selectiontype="&venues=";
    var projI=new OpenLayers.Projection("EPSG:900913");
    var projE=new OpenLayers.Projection("EPSG:4326");
    var currentlocation = (new OpenLayers.LonLat(W.map.center.lon,W.map.center.lat)).transform(projI,projE).toString().replace(',','&');
    $.each(W.selectionManager.getSelectedFeatures(), function(indx, section){
        if(selectedindex!=="")
        {
            selectedindex=selectedindex + ",";
        }
        selectedindex = selectedindex + section.model.attributes.id;
        if(section.model.type !== 'venue')
        {
            selectiontype="&segments=";
        }
        segmentcount++;
    });
    return (text + currentlocation + "&zoom=" + W.map.zoom + selectiontype + selectedindex);
}

function VersionCheck() {
    ///////////////////////////////////////
    //  Verification de la mise à jour   //
    ///////////////////////////////////////
    if (localStorage.getItem('WMESTSVersion') === ScriptVersion && 'WMESTSVersion' in localStorage) {

    } else if ('WMESTSVersion' in localStorage) {
        if(!WazeWrap.Interface) {
            setTimeout(VersionCheck, 1000);
            log("WazeWrap not ready, waiting");
            return;
        }
        WazeWrap.Interface.ShowScriptUpdate(ScriptName, ScriptVersion, UpdateNotes, "https://gitlab.com/WMEScripts/WME-send-to-slack-public");
        localStorage.setItem('WMESTSVersion', ScriptVersion);
        $(".WWSUFooter a").text("Gitlab")
    }
    else
    {
        localStorage.setItem('WMESTSVersion', ScriptVersion);
    }
}

function initializeFirstUseInterface() {
    log("creating first use interface");
}

function CheckNeededParams() {
    log("Checking the needed parameters");
    for (var key in neededparams){
        if(!(neededparams.hasOwnProperty(key) in localStorage)) {
            $('#WSTSFS-Container').hide();
            log(key + ' manquant');
        }
    }
    initializeFirstUseInterface();
}
init();
