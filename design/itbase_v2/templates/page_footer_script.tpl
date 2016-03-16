<script src={'javascript/bootstrap/tab.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/dropdown.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/collapse.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/affix.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/alert.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/button.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/carousel.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/modal.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/tooltip.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/popover.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/scrollspy.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/transition.js'|ezdesign()}></script>

{*
 -- LA PARTE DI GOOGLE ANALYTICS VIENE IMPOSTATA NELLA FRONTPAGE VIA BACKEND --
 
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', "{appini('GoogleAnalytics','Account')}"]);
  _gaq.push(['_setDomainName', "{appini('GoogleAnalytics','DomainName')}"]);
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);
  (function() {ldelim}
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  {rdelim})();
</script>
*}

{* Visualizzazione ad albero *}
{literal}
<script type="text/javascript">
    $(function () {
        $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        $('.tree li.parent_li > span').on('click', function (e) {
            var children = $(this).parent('li.parent_li').find(' > ul > li');
            if (children.is(":visible")) {
                children.hide('fast');
                $(this).attr('title', 'Expand this branch').find(' > i').addClass('fa-folder').removeClass('fa-folder-open');
                //$(this).attr('title', 'Expand this branch').find(' > i').addClass('text-success').removeClass('text-danger');
            } else {
                children.show('fast');
                $(this).attr('title', 'Collapse this branch').find(' > i').addClass('fa-folder-open').removeClass('fa-folder');
                //$(this).attr('title', 'Expand this branch').find(' > i').addClass('text-danger').removeClass('text-success');
            }
            e.stopPropagation();
        });
    });
</script>
{/literal}

{* Menu incollato in alto *}
{literal}
<script type="text/javascript">
    $(document).ready(function() {
        $('#myNav').affix({
            offset: {
              top: $('header').height()
            }
         });
    });
    
    // Inizializzazione tooltip
    $(function () {
        $('[data-toggle-tt="tooltip"]').tooltip();
    });
</script>
{/literal}
