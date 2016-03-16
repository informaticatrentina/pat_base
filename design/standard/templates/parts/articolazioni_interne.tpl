{if is_set($no_servizi)|not()}
	{def $no_servizi=false()}
{/if}

{def 
    $servizi_correlati=array()
    $incarichi_correlati=array()
    $incarico_uffici_correlati=array()
    $incarico_ufficio_strutture_correlate=array()
    $incarico_ufficio_strutture_strutture_correlate=array()
    $incarico_ufficio_altre_strutture_correlate=array()			
    $incarico_strutture_correlate=array()
    $incarico_altre_strutture_correlate=array()
    $dipendenti_correlati=array()
    $uffici_correlati=array()
    $ufficio_strutture_correlate=array()
    $ufficio_strutture_strutture_correlate=array()
    $ufficio_altre_strutture_correlate=array()
    $strutture_correlate=array()
    $strutture_strutture_correlate=array()
    $altre_strutture_correlate=array()
    $done=array()

    $classi_con_area = class_attributes( array('area') )  
    $classe_con_area = false()
    $classi_con_questonodo = class_attributes( array($node.class_identifier) ) 
    $ccqn = array()
}

{foreach $classi_con_area as $ccs}
	{if $ccs.identifier|eq($node.class_identifier)}
		{set $classe_con_area = true() }
	{/if}
{/foreach}

{foreach $classi_con_questonodo as $ccq}
	{set $ccqn = $ccqn|merge(array($ccq.identifier))}
{/foreach}


{if $no_servizi|not}
  {if $classe_con_area}
    {set $servizi_correlati= fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', concat($node.class_identifier,'/area'), 'sort_by',  array( 'name', true() ) ) )}  
  {elseif $ccqn|contains('servizio')}
    {set $servizi_correlati= fetch( 'content', 'reverse_related_objects',  hash( 'object_id', $node.object.id,  'attribute_identifier', concat('servizio/',$node.class_identifier), 'sort_by',  array( 'name', true() ) ) )}
  {/if}	
{/if}

{if $ccqn|contains('incarico')}
	{set $incarichi_correlati= fetch( 'content', 'reverse_related_objects',  hash( 'object_id', $node.object.id,  'attribute_identifier', concat('incarico/',$node.class_identifier), 'sort_by',  array( 'name', true() ) ) )}
{/if}

{if $ccqn|contains('ufficio')}					
  {set $uffici_correlati= fetch( 'content', 'reverse_related_objects',  hash(  'object_id',$node.object.id, 'attribute_identifier',  concat('ufficio/',$node.class_identifier), 'sort_by',  array( 'name', true() ) ) )}				
{/if}

{if $ccqn|contains('struttura')}	
  {set $strutture_correlate=fetch( 'content', 'reverse_related_objects',  hash( 'object_id', $node.object.id, 'attribute_identifier', concat('struttura/',$node.class_identifier), 'sort_by',  array( 'name', true() )  ) )}
{/if}					

{if $ccqn|contains('altra_struttura')}
  {set $altre_strutture_correlate=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', concat('altra_struttura/',$node.class_identifier), 'sort_by',  array( 'name', true() ) ) )}
{/if}


{if or( $incarichi_correlati|count(), $uffici_correlati|count(), $altre_strutture_correlate|count(), $strutture_correlate|count(), $servizi_correlati|count() )}
	
			
    {if $servizi_correlati|count()}						
			<ul class="servizi_correlati">
			{foreach $servizi_correlati as $object_correlato}
				{if $object_correlato.id|ne($node.contentobject_id)}					
          {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
            <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
					{/if}	
				{/if}
			{/foreach}
			</ul>
		{/if}

		{if $incarichi_correlati|count()}						
			<ul class="incarichi_correlati">
			{foreach $incarichi_correlati as $incarico}
				{if $incarico.id|ne($node.contentobject_id)}					
          {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($incarico.section_id)}
					  <li>
						<div class="vcard"><h2><a href= {$incarico.main_node.url_alias|ezurl()}>{$incarico.name}</a></h2></div></li>

						{set $incarico_uffici_correlati= fetch( 'content', 'reverse_related_objects',  hash(  'object_id',$incarico.id, 'attribute_identifier',  'ufficio/incarico', 'sort_by',  array( 'name', true() ) ) )}
						{set $incarico_altre_strutture_correlate=fetch( 'content', 'reverse_related_objects',  hash( 'object_id', $incarico.id, 'attribute_identifier', 'struttura/incarico', 'sort_by',  array( 'name', true() )  ) )}
						{set $incarico_strutture_correlate=fetch( 'content', 'reverse_related_objects',  hash( 'object_id', $incarico.id, 'attribute_identifier', 'altra_struttura/incarico', 'sort_by',  array( 'name', true() ) ) )}							   
					   
						{if or( $incarico_uffici_correlati|count(), $incarico_altre_strutture_correlate|count(), $incarico_strutture_correlate|count() )}
							<ul class="altri_correlati">
							{if $incarico_uffici_correlati|count()}	
								{foreach $incarico_uffici_correlati as $object_correlato}																	
									{if $object_correlato.id|ne($node.contentobject_id)}										
                    {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                      {set $done = $done|append($object_correlato.id)}
										  <li>
                        <div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div>										   
                        {set $incarico_ufficio_strutture_correlate= fetch( 'content', 'reverse_related_objects', hash( 'object_id', $object_correlato.id,'attribute_identifier', 'struttura/ufficio','sort_by',  array( 'name', true() ) ) )}
                        {set $incarico_ufficio_altre_strutture_correlate= fetch( 'content', 'reverse_related_objects', hash( 'object_id', $object_correlato.id,'attribute_identifier', 'altra_struttura/ufficio','sort_by',  array( 'name', true() )) )}			
                           
                        {if or( $incarico_ufficio_strutture_correlate|count(), $incarico_ufficio_strutture_correlate|count() )}
                          <ul>
                        
                          {if $incarico_ufficio_altre_strutture_correlate|count()}	
                            {foreach $incarico_ufficio_altre_strutture_correlate as $object_correlato_}
                              {if $object_correlato_.id|ne($node.contentobject_id)}
                                {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato_.section_id)}
                                  {set $done = $done|append($object_correlato_.id)}
                                  <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
                                {/if}	
                              {/if}
                            {/foreach}
                          {/if}
                          
                          {if $incarico_ufficio_strutture_correlate|count()}	
                            {foreach $incarico_ufficio_strutture_correlate as $object_correlato_}
                              {if $object_correlato_.id|ne($node.contentobject_id)}
                                {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato_.section_id)}
                                  {set $done = $done|append($object_correlato_.id)}
                                  <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
                                {/if}	
                              {/if}
                            {/foreach}
                          {/if}						
                          
                          </ul>
                        {/if}										   
											</li>
										{/if}	
									{/if}
								{/foreach}
							{/if}
							
							{if $incarico_altre_strutture_correlate|count()}	
								{foreach $incarico_altre_strutture_correlate as $object_correlato}
									{if $object_correlato.id|ne($node.contentobject_id)}
										{if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                      {set $done = $done|append($object_correlato.id)}
										  <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
										{/if}	
									{/if}
								{/foreach}
							{/if}
							
							{if $incarico_strutture_correlate|count()}	
								{foreach $incarico_strutture_correlate as $object_correlato}
									{if $object_correlato.id|ne($node.contentobject_id)}
										{if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                      {set $done = $done|append($object_correlato.id)}
										  <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
										{/if}	
									{/if}
								{/foreach}
							{/if}						
							</ul>
						{/if}					   
					
          {/if}	
				{/if}
			{/foreach}
			</ul>
		{/if}

		{if $uffici_correlati|count()}
			<ul class="uffici_correlati">
			{foreach $uffici_correlati as $ufficio}
				{if $ufficio.id|ne($node.contentobject_id)}
					{if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($ufficio.section_id)}
            {if $done|contains($ufficio.id)|not()}
					  <li>
              <div class="vcard"><h2><a href= {$ufficio.main_node.url_alias|ezurl()}>{$ufficio.name}</a></h2></div>

              {set $dipendenti_correlati = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $ufficio.id,'attribute_identifier', 'dipendente/ufficio','sort_by',  array( 'name', true() ) ) )}

              {if $dipendenti_correlati}
              <ul>
                {if $ufficio.data_map.responsabile|has_content}
                  {def $responsabile = fetch('content','node',hash('node_id',$ufficio.data_map.responsabile.content.relation_list[0].node_id))}
                  <li>
                    <div class="vcard"><h2>Direttore: <a href= {$responsabile.main_node.url_alias|ezurl()}>{$responsabile.name}</a></h2></div>
                  </li>
                {/if}
                {foreach $dipendenti_correlati as $dip}
                  {if ne($dip.main_node_id,$responsabile.node_id)}
                  <li>
                    <div class="vcard"><h2>Collaboratore: <a href= {$dip.main_node.url_alias|ezurl()}>{$dip.name}</a></h2></div>
                  </li>
                  {/if}
                {/foreach}
              </ul>

              {/if}



              {set $ufficio_strutture_correlate=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $ufficio.id,'attribute_identifier', 'struttura/ufficio','sort_by',  array( 'name', true() ) ) )}	
						
              {if $ufficio_strutture_correlate|count()}
                <ul>
                {if $ufficio_strutture_correlate|count()}	
                  {foreach $ufficio_strutture_correlate as $object_correlato}
                    {if $object_correlato.id|ne($node.contentobject_id)}
                      {if $object_correlato.data_map.struttura.has_content|not()}
                        {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                          {if $done|contains($object_correlato.id)|not()}
                            {set $done = $done|append($object_correlato.id)}
                            <li>
                              <div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div>
                              {set $ufficio_strutture_strutture_correlate =fetch( 'content', 'reverse_related_objects', hash( 'object_id', $object_correlato.id,'attribute_identifier', 'struttura/struttura','sort_by',  array( 'name', true() ) ) )}	
  
                              {if $ufficio_strutture_strutture_correlate|count()}
                              <ul>	
                                {foreach $ufficio_strutture_strutture_correlate as $object_correlato}
                                  {if $object_correlato.id|ne($node.contentobject_id)}
                                    {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                                      {if $done|contains($object_correlato.id)|not()}
                                        {set $done = $done|append($object_correlato.id)}
                                        <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
                                      {/if}
                                    {/if}	
                                  {/if}
                                {/foreach}
                              </ul>
                              {/if}
                            </li>
                          {/if}	
                        {/if}
                      {/if}
                    {/if}
                  {/foreach}
  							{/if}
                </ul>
              {/if}
            </li>
            {/if}
          {/if}
        {/if}
			{/foreach}
			</ul>
		{/if}			 
			
		{if $strutture_correlate|count()}						
			<ul>
        
			{foreach $strutture_correlate as $object_correlato}
				{if $object_correlato.id|ne($node.contentobject_id)}
          {if $object_correlato.data_map.struttura.has_content|not()}
            {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
              {if $done|contains($object_correlato.id)|not()}
                {set $done = $done|append($object_correlato.id)}
                <li>
                  <div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div>						
                  {set $strutture_strutture_correlate=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $object_correlato.id,'attribute_identifier', 'struttura/struttura','sort_by',  array( 'name', true() ) ) )}	

                  {if $strutture_strutture_correlate|count()}
                  <ul>	
                  {foreach $strutture_strutture_correlate as $object_correlato}
                    {if $object_correlato.id|ne($node.contentobject_id)}
                      {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
                        {if $done|contains($object_correlato.id)|not()}
                          {set $done = $done|append($object_correlato.id)}
                          <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
                        {/if}	
                      {/if}	
                    {/if}
                  {/foreach}
                  </ul>
                  {/if}
                </li>
              {/if}	
            {/if}	
          {/if}
				{/if}
			{/foreach}
			
      {foreach $strutture_correlate as $object_correlato}	
				{if $object_correlato.data_map.struttura.has_content}
					{if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
						{if $done|contains($object_correlato.id)|not()}
							{set $done = $done|append($object_correlato.id)}
              <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
            {/if}
					{/if}	
				{/if}
			{/foreach}

			</ul>
		{/if}	

		{if $altre_strutture_correlate|count()}						
			<ul>
			{foreach $altre_strutture_correlate as $object_correlato}
				{if $object_correlato.id|ne($node.contentobject_id)}
					{if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array(1) )|contains($object_correlato.section_id)}
            {if $done|contains($object_correlato.id)|not()}
              <li><div class="vcard"><h2><a href= {$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></h2></div></li>
            {/if}	
					{/if}					
				{/if}
			{/foreach}
			</ul>
		{/if}			 
	
{/if}