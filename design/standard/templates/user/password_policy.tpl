{literal}
<script>
    var siteURL = '{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}';

    $(document).ready(function () {
        $('form').submit(function(){
            var old_password_check = false;
            var password_policy_check = false;
            var password_already_used = true;
            var login = '{/literal}{$userAccount.login}{literal}';

            $.ajax(
                {
                    url: "https://" + siteURL + "/ptn/password_policy/"+ $("#pass").val() + '/' + $("#newPassword").val() + '/' + login,
                    success: function(result){
                        old_password_check = result.old_password_check;
                        password_policy_check = result.password_policy_check;
                        password_already_used = result.password_already_used;

                        $("#Messages").hide();
                        $("#OldPasswordMessage").hide();
                        $("#PasswordPolicyMessage").hide();
                        //$("#AlreadyUsedMessage").hide();

                        if(!old_password_check){
                            $("#OldPasswordMessage").show();
                        }
                        else if(!password_policy_check){
                            $("#PasswordPolicyMessage").show();
                        }
                        else if(password_already_used){
                            $("#AlreadyUsedMessage").show();
                        }
                    },
                    async: false
                }
            );

            console.log(old_password_check && password_policy_check && !password_already_used);

            return old_password_check && password_policy_check && !password_already_used;
            //return false;
        });



        $("#info_privacy").click(function (event) {
            if( !$(this).hasClass('is-checked') ){
                $("#okButton").removeAttr("disabled");
                $("#okButton").removeClass("is-disabled");
            }
            else{
                $("#okButton").attr("disabled", true);
                $("#okButton").addClass("is-disabled");
            }
        });

        $('#privacy-bootstrap').change(function() {
            if( $("#okButton").is(":disabled") ){
                $("#okButton").removeAttr("disabled");
                $("#okButton").removeClass("is-disabled");
            }
            else{
                $("#okButton").attr("disabled", true);
                $("#okButton").addClass("is-disabled");
            }
        });
    });
</script>
{/literal}