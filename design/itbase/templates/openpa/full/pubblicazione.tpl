
<div class="content-view-full class-{$node.class_identifier} row">

  <div class="content-title">
      
       {if $node|has_attribute( 'tematica' )}
            <p class="pull-right">

                {if $node|has_attribute( 'tematica' )}
                    <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'tematica' )}</span>
                {/if}
            </p>
        {/if}
        
        <h1>{$node.name|wash()}</h1>
  </div>

  <div class="col-md-4">
    {if $node|has_attribute( 'image' )}
      {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes='image-main'}
    {else}
        <div class="figure image-main" style="height:200px;width:500px;">
        </div>
    {/if}
  </div>
  
  <div class="col-md-3 col-md-push-5" >

      {if $node|has_attribute( 'testata' )}
        {foreach $node.object.data_map.testata.content.relation_list as $relation}
          {def $abbonamenti = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $relation.contentobject_id, 'attribute_identifier', 'abbonamento_rivista/testata' ) )}
          {if count( $abbonamenti )|gt(0)}
            {foreach $abbonamenti as $abbonamento}
                <p><a href="{$abbonamento.main_node.url_alias|ezurl(no)}" class="btn btn-primary btn-lg">{$abbonamento.name|wash()}</a></p>
            {/foreach}
          {/if}
          {undef $abbonamenti}
        {/foreach}
      {/if}

      {if $node|has_attribute( 'sfoglia_online' )}
          <p>
              <a href="{$node.object.data_map.sfoglia_online.content}" target="_blank" class="btn btn-primary btn-info btn-lg"><i class="fa fa-tablet"></i> Sfoglia online</a>
          </p>
      {/if}

      {if $node|has_attribute( 'file' )}
          <div class="allegato">
              <i class="fa fa-download"></i>{attribute_view_gui attribute=$node|attribute( 'file' )}
          </div>
      {/if}
      
      {if $node|has_attribute( 'argomento' )}
          <div class="tags">
               <h2><i class="fa fa-tags"></i> Argomento</h2>
               {attribute_view_gui attribute=$node|attribute( 'argomento' )}
          </div>
      {/if}
     

        
      {def $articoli=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', 'article/pubblicazione' ) )}
      {if $articoli|count()|gt(0)}
          <h3><i class="fa fa-newspaper-o"></i> Articoli</h3>
          <ul class="list-unstyled">
              {foreach $articoli as $articolo}
                  <li class="pubblicazione"><a href={$articolo.main_node.url_alias|ezurl("no")}>{$articolo.name}</a></li>
              {/foreach}
          </ul>
      {/if}
  
  </div>

  <div class=" col-md-5 col-md-pull-3">
      
     {if $node|has_attribute( 'abstract' )}
        <div class="abstract">
            {attribute_view_gui attribute=$node|attribute( 'abstract' )}
         </div>
     {/if}

     {if $node|has_attribute( 'sommario' )}
        <h3><i class="fa fa-list"></i> Sommario</h3>
        <div class="sommario-rivista">
            <p>{attribute_view_gui attribute=$node|attribute( 'sommario' )}</p>
        </div>
     {/if}

  </div>

        
</div>

    {if $node|has_attribute( 'descrizione' )}
    <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'descrizione' )}
    </div>
    {/if}
