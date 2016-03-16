{* :: INFOTN :: *}


<li class="media">
    <div class="media-object">
     {if $child|has_attribute( 'immagini' )}     
        {*attribute_view_gui attribute=$curImages|attribute('image') image_class=$thumbnail_class fluid=$fluid*}
        {set_defaults( hash(  
               'thumbnail_class', 'squarethumb',
               'wide_class', 'imagefullwide',
               'items', array(),
               'fluid', false(),
               'mode', 'strip'
           ))} 
       {*def $curImage = fetch('content','node',hash('node_id',$child.data_map.immagini.content.relation_list[0].node_id))*}
       <a href={$child.url_alias|ezurl()} title="{$child.name|wash()}" class="pull-left">
            {*attribute_view_gui attribute=$curImage|attribute('image') image_class=$thumbnail_class fluid=$fluid *}
           
            {def $com_img = fetch('content','node',hash('node_id',$child.data_map.immagini.content.relation_list[0].node_id))}
            {def $com_img_url = $com_img|attribute('image').content[$thumbnail_class]}
            
            <figure style="background: url( {$com_img_url.url|ezroot(no)} )"></figure>
            {undef $com_img
                   $com_img_url}
       </a>
    {/if}
    
        <p class="media-abstract">
            <a href={$child.url_alias|ezurl()} title="{$child.name|wash()}" >
                <small>{$child.object.published|l10n('shortdate')} - </small>
                {$child.name|wash()}
            </a>
            
        </p>
        
        
       {* <p class="media-abstract"></p>

        {def $icon = ezini( 'ClassIcons', $child.object.class_identifier, 'fa_icons.ini.append.php' )}*}
    
    </div>
</li>
