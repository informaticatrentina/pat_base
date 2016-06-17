
<div class="text-left" style="padding-bottom: 5px; ">
        {* icone che indicano solo quali contentuti (side) sono presenti *}
            {* immagini *}     
            {def $hasImages = 0}            
            {if $node|has_attribute( 'immagini' )}
                {foreach $node.data_map.immagini.content.relation_list as $relation_item}
                    {set $hasImages = 1}                    
                {/foreach}
            {/if}
            {if eq($hasImages,1)}<i class="fa fa-camera" style="padding-right:5px"></i>{/if}            
            {* allegati *} 
            {if $node|has_attribute( 'allegati' )}              
                <i class="fa fa-paperclip" style="padding-right:5px"></i>               
            {/if}
            {* audio *} 
            {if $node|has_attribute( 'audio' )}<i class="fa fa-volume-up " style="padding-right:5px"></i>{/if}
            {if or($node|has_attribute( 'telefono' ), $node|has_attribute( 'email' ))} <i class="fa fa-thumb-tack" style="padding-right:5px"></i>{/if}
            {if $node|has_attribute( 'fonte' )} <i class="fa fa-code-fork" style="padding-right:5px"></i>{/if}
            {if $node|has_attribute( 'geo' )} <i class="fa fa-map-marker" style="padding-right:5px"></i>{/if}
            {* link *} 
            {def $hasLink = 0}
            {if $node|has_attribute( 'link' )}
                {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
                    {foreach $row.columns as $index => $column}
                        {if $column|ne('')}
                             {def $hasLink = 1} 
                        {/if}
                    {/foreach}
                {/foreach}
            {/if}
            {if eq($hasLink,1)}<i class="fa fa-link" style="padding-right:5px"></i>{/if}   
            
            {*if $node|has_attribute( 'tematica' )}
                {def $attribute = $node|attribute( 'tematica' )}
                <i class="fa fa-tag" style="padding-right:5px" data-toggle="tooltip" data-placement="right" title="
                   {foreach $attribute.content.tags as $tag}                   
                       {$tag.keyword|wash}
                       {delimiter} - {/delimiter}
                    {/foreach}
                "></i>
            {/if*}            
</div> 
            
            
{literal}
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
{/literal}