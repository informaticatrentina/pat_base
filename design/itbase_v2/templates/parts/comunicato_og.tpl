{def $image = false()}
{if $node|has_attribute( 'immagini' )}
  {foreach $node.data_map.immagini.content.relation_list as $relation_item}
    {set $image = fetch('content','node',hash('node_id',$relation_item.node_id)).data_map.image.content['imagefullwide']}
    {break}
  {/foreach}
{/if}

{def $image_url = false()}

{if $image}
    {set $image_url = concat('"', 'https://', ezini('SiteSettings','SiteURL'), $image.url|ezroot(no), '"')}
{else}
    {*Logo sito ufficio stampa*}
    {def $media_node_id = ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' )}
    {def $media_list=fetch( 'content', 'list', hash( 'parent_node_id', $media_node_id) )}

    {foreach $media_list as $media}
        {if and($media.name|eq('LogoMail'), $media.class_identifier|eq('image'))}
            {def $logo_image = $media}
        {elseif and($media.name|eq('LogoIlPunto'), $media.class_identifier|eq('image'))}
            {def $logo_ilpunto_image = $media}
        {/if}
    {/foreach}

    {def $objImg = $logo_image|attribute('image')}
    {def $image = $objImg.content['imagefull']}

    {set $image_url = $image.url|ezurl(,'full')}

    {set $image_url = $image_url|explode('http')|implode('https')}
{/if}

{def $cur_occhiello = false()}
{if $node|has_attribute( 'occhiello' )} 
    {set $cur_occhiello = $node.data_map.occhiello.content|wash()} 
{else}
    {set $cur_occhiello = ' - '}
{/if}
 

<meta property="og:site_name" content="Ufficio Stampa Provincia Autonoma di Trento" />
<meta property="og:url" content="{concat('https://', ezini('SiteSettings','SiteURL'), $node.url_alias|ezroot(no))}" />
<meta property="fb:app_id" content="1201175013229984" />
<meta property="og:country-name" content="Italy" />
<meta property="og:type" content="article" />
<meta property="og:title" content="{$node.name|wash()}" />
<meta property="og:description" content="{$cur_occhiello|wash()}" />
<meta property="og:image" content={$image_url} />

{undef $image
       $cur_occhiello}