{* File - List embed view *}
<div class="content-view-embed">
    <div class="class-file">
    {if $object.data_map.file.has_content}
    {def $file = $object.data_map.file}
    <div class="content-body attribute-{$file.content.mime_type_part|explode('.')|implode('-')}">
	{*<a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>{$file.content.original_filename|wash("xhtml")}</a> {$file.content.filesize|si(byte)}*}
        
        <a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>
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
            {$object.name|wash}
        </a>
    </div>
    {undef $file}
    {else}
    <div class="content-body">
        <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
    </div>
    {/if}
   </div>
</div>