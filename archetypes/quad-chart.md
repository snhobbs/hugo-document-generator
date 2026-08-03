---
title: {{ replace .Name "-" " " | title }}
subtitle: ""
description: "One-page pitch summary"
date: {{ .Date }}
draft: true
client: ""
contact: ""
categories: []
tags: []
# Optional: drop a small photo/diagram into any quadrant. Filename is
# resolved from this page's bundle first, then global assets/ — same
# lookup as the imgprint shortcode. Leave unset for a text-only cell.
# quad_tl_image: "photo.jpg"
quad_tl_title: "Opportunity"
quad_tl: |
  The problem or market gap, in a sentence or two.
quad_tr_title: "Approach"
quad_tr: |
  What we're proposing.
quad_bl_title: "Schedule"
quad_bl: |
  Key milestones or lead times.
quad_br_title: "Next Steps"
quad_br: |
  1. Step one
  1. Step two
---
