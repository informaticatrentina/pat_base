{if $attribute.content.tag_ids|count}
    {foreach $attribute.content.tags as $index => $tag}        
        {$tag.keyword|wash}{if $index|lt(count($attribute.content.tags)|sub(1))}{$separatore}{/if}
    {/foreach}
{/if}