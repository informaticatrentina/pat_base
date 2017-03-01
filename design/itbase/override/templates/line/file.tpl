<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
    <h3 class="media-heading">
        {def $file = $node|attribute( 'file' )}
        {def $file_url = concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )}
        
        {if $file.content.original_filename|wash("xhtml")|ends_with('pdf')}
            <i class="fa fa-file-pdf-o"></i>
        {elseif $file.content.original_filename|wash("xhtml")|ends_with('doc')}
            <i class="fa fa-file-word-o"></i>
        {elseif $file.content.original_filename|wash("xhtml")|ends_with('docx')}
            <i class="fa fa-file-word-o"></i>
        {elseif $file.content.original_filename|wash("xhtml")|ends_with('odf')}
            <i class="fa fa-file-word-o"></i>
        {elseif $file.content.original_filename|wash("xhtml")|ends_with('xls')}
            <i class="fa fa-file-excel-o"></i>
        {elseif $file.content.original_filename|wash("xhtml")|ends_with('xlsx')}
            <i class="fa fa-file-excel-o"></i>
        {else}
            <i class="fa fa-file"></i>
        {/if}
         <div class="pull-right">
            {include uri='design:parts/toolbar/node_toolbar.tpl' current_node=$node}
         </div>
        <a href={$file_url|ezurl( 'no' )}>{$node.name|wash}</a>
        
        {undef $file
               $file_url}
    </h3>
    {*include uri='design:atoms/file.tpl' size=btn-xs file=$node|attribute( 'file' )*}
    {if $node|has_abstract()}
        {$node|abstract()}
    {/if}
    {if $node|has_attribute('description')}
        <p>
            {attribute_view_gui attribute=$node|attribute( 'description' )}
        </p>
    {/if}
  </div>
</div>