<div class="row">
  <div class="col-md-8 repository_search">
	{if is_set( $repository.results.count )}
	  {if $repository.results.count|gt(0)}
		
		{if $repository.results.count|eq(1)}
		  <h2>
                      Trovato {$repository.results.count} risultato
                  </h2>
		{else}
		  <h2>
                      Trovati {$repository.results.count} risultati
                      <small>
                          pagina 
                          {if ezhttp_hasvariable('offset', 'get')}
                            {ezhttp('offset', 'get')|div(10)|sum(1)}
                          {else}
                            1
                          {/if}
                          di 
                          {$repository.results.count|div(10)|ceil()}
                      </small>
                  </h2>
		{/if}
		
		<p>
		  {foreach $repository.results.fields as $field}
			<span class="label label-primary">{$field.name}: {$field.value}</span>
		  {/foreach}
		</p>
                
               
                
		<table class="table table-striped">
		  <tr>
			<th>Titolo</th>		  
			<th>Link al sito originale</th>
			<th>Link</th>
		  </tr>
		{foreach $repository.results.contents as $content}
                    {def $name = cond( is_set( $content.name_t ), $content.name_t, $content.name )
                          $installation_url = cond( is_set( $repository.definition.Url ), $repository.definition.Url, $content.installation_url )
                          $main_url_alias = cond( is_set( $content.main_url_alias_ms ), $content.main_url_alias_ms, $content.main_url_alias )
                          $url = concat( $installation_url, $main_url_alias )
                          $main_node_id = cond( is_set( $content.main_node_id_si ), $content.main_node_id_si, $content.main_node_id )
                          $remote_id = cond( is_set( $content.remote_id_ms ), $content.remote_id_ms, $content.remote_id )
                          $imported = fetch( 'content', 'object', hash( 'remote_id', $remote_id ))}      
                    <tr {if $imported}class="success"{/if} >
                        <td>
                            <small>{$name|wash()}</small>
                        </td>
                        <td>
                            {if $repository.definition.OriginalDisabled|eq('true')}
                                <a class="btn btn-sm btn-info disabled" href="">
                            {else}
                                <a class="btn btn-sm btn-info" target="_blank" href="{$url}">
                            {/if}
                                <i class="fa fa-external-link"></i>
                                Vai all'originale
                            </a>
                        </td>
                        <td>			  
                            {if $imported}
                                {def $importedNode = $imported.main_node}
                                    <a class="btn btn-sm btn-success" href={$importedNode.url_alias|ezurl()}>
                                        <i class="fa fa-link"></i>
                                        Visualizza
                                    </a>
                                {undef $importedNode}
                            {else}				
                                <a class="btn btn-sm btn-danger" href={concat( 'repository/import/', $repository.definition.Identifier, '/', $main_node_id )|ezurl()}>
                                    <i class="fa fa-download"></i>
                                    Importa
                                </a>
                            {/if}			  
                        </td>
                   </tr>
                    {undef $name $installation_url $main_url_alias $url $main_node_id $remote_id $imported}
		{/foreach}
		</table>
                
                <hr>
                
                {*mi ricavo l'url per andare alla prox pagina ed alla precedente*}
                {def $next_url = ''}
                {def $prev_url = ''}
                {def $url_split = $repository.results.next|explode('?')}

                {if $url_split|count()|gt(0)}
                    {def $url_par = $url_split[1]|explode('&')}

                    {set $next_url = concat($url_split[0], '?')}
                    {set $prev_url = concat($url_split[0], '?')}

                    {foreach $url_par as $par}
                        {if $par|begins_with('offset=')}
                            {def $offset_par = $par|explode('=')}

                            {def $offset_next = $offset_par[1]|sum(10)}
                            {def $offset_prev = $offset_par[1]|sub(10)}

                            {set $next_url = concat($next_url, $offset_par[0], '=', $offset_next, '&')}
                            {set $prev_url = concat($prev_url, $offset_par[0], '=', $offset_prev, '&')}
                        {else}
                            {set $next_url = concat($next_url, $par, '&')}
                            {set $prev_url = concat($prev_url, $par, '&')}
                        {/if}
                    {/foreach}
                {/if}
                
		{if $offset_prev|gt(-1)}
		  <a class="btn btn-primary btn-sm pull-left" href={$prev_url|ezurl()}>
                      <i class="fa fa-backward"></i>
                      Precedente
                  </a>
		{/if}
		{if $offset_next|lt($repository.results.count)}
                    {if $next_url|ne('')}
                        <a class="btn btn-primary btn-sm pull-right" href={$next_url|ezurl()}>
                            Successiva
                            <i class="fa fa-forward"></i>
                        </a>
                    {/if}
		{/if}
	  {else}
		<h2>Nessun risultato</h2>
		<p>
		  {foreach $repository.results.fields as $field}
			<span class="label label-primary">{$field.name}: {$field.value}</span>
		  {/foreach}
		</p>
	  {/if}
        {else}
            <h2>
                Ricerca contenuti<br/>
                <small>
                    Usa il pannello a destra per ricercare i contenuti da importare.
                </small>
            </h2>
	{/if}
  </div>
  <div class="col-md-4">
	{$repository.form}
  </div>
</div>