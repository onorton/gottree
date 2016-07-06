
class FullTreeController < ApplicationController
  def index
    @tree_html = "<div class=\"tree\">
		<ul>
			<li>
				<a href=\"#\">
          <p>Eddard Stark</p>
          <p>263-299</p>
        </a><a href=\"#\">
          <p>Catelyn Stark</p>
          <p>263-299</p>
        </a>
				<ul>
					<li>
            <a href=\"#\">
              <p>Robb Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Sansa Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Arya Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Bran Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Rickon Stark</p>
              <p>263-299</p>
            </a>
					</li>
				</ul>
			</li>
		</ul>
	</div>"
  end
end
