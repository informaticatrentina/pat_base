{literal}
<script>
    var siteURL = '{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}';
    var userID = '{/literal}{$userID}{literal}';

    $(document).ready(function () {
        $.ajax(
            {
                url: "https://" + siteURL + "/ptn/password_updated/"+ userID,
                success: function(result){
                    // Go Home
                    window.setTimeout(function() {
                        window.location.href = "https://" + siteURL;
                    }, 2000);
                }
            }
        );
    });
</script>
{/literal}