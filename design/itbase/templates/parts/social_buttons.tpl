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
<!--
{literal}
    <script type="text/javascript">var switchTo5x=true;</script>
{/literal}
    <script type="text/javascript" src={"javascript/buttons.js"|ezdesign()} ></script>
{literal}    
    <script type="text/javascript">stLight.options({publisher: "db65f574-01f6-4588-ac37-45a1c1dca7a9", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>
{/literal}
-->
{literal}
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-567518f58119c315" async="async"></script>
{/literal}
<div>
    
    {def $cur_occhiello = false()}
    {if $node|has_attribute( 'occhiello' )} 
        {set $cur_occhiello = $node.data_map.occhiello.content|wash()} 
    {else}
        {set $cur_occhiello = ' - '}
    {/if}
   
      <!--span class='st_facebook_large' displayText='Facebook' class="pull-left" st_image={$image_url}></span>-->
    
      <span class='st_facebook_large' displayText='Facebook' class="pull-left" st_image={$image_url}></span>
      
      
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:image" content={$image_url}>
      <meta name="twitter:domain" content="www.ufficiostampa.provincia.tn.it">
      <meta name="twitter:site" content="@ufficiostampa.provincia.tn.it">
      <meta name="twitter:creator" content="@ufficiostampa.provincia.tn.it">
      <meta name="twitter:title" content="{$node.name|wash()}">
      <meta name="twitter:description" content="{$cur_occhiello}">
      
      
        <div class="addthis_toolbox addthis_default_style">	
            <div class="addthis_sharing_toolbox"></div>
        </div> 
     
    
      <!--
      <meta name="twitter:description" content="{$node.name|wash()}">
      <meta name="twitter:title" content="{$node.name|wash()}">
      
      <span class='st_twitter_large' 
            displayText='Tweet' 
            class="pull-left" 
            st_title="{$node.name|wash()}" 
        ></span>
        
            
      <span class='st_googleplus_large' displayText='Google +' class="pull-left" st_image={$image_url}></span>
      <span class='st_linkedin_large' displayText='LinkedIn' class="pull-left" st_image={$image_url}></span>
      <span class='st_pinterest_large' displayText='Pinterest' class="pull-left" st_image={$image_url}></span>
      <span class='st_email_large' displayText='Email' class="pull-left" st_image={$image_url}></span>
      -->
</div>
