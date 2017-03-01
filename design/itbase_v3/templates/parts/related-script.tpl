{set_defaults( hash(
    'margin', 52,
))}

{literal}
    <script type="text/javascript">
        // Regola posizione dell'icona

        function setRelatedIconsMargin(){
            var parent_width = $(".related-icon").parent().width();
            var margin = parent_width - {/literal}{$margin}{literal};

            console.log('related width: ' + parent_width);
            console.log('related margin: ' + margin);

            $(".related-icon").css("margin-left", margin + "px");
        }

        $( document ).ready( setRelatedIconsMargin() );
        
        /*
        $( window ).resize( setRelatedIconsMargin() );
        */
    </script>
{/literal}