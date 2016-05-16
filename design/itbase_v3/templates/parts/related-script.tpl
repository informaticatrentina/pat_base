{literal}
    <script type="text/javascript">
        // Regola posizione dell'icona

        function setRelatedIconsMargin(){
            var parent_width = $(".related-icon").parent().width();
            var margin = parent_width - 52;

            $(".related-icon").css("margin-left", margin + "px");
        }

        $( document ).ready( setRelatedIconsMargin() );
        // $(window).on('resize', setRelatedIconsMargin() );
    </script>
{/literal}