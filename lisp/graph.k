(setq a '((b 2) (c 4) (d 5))
      b '((e 9))
      c '((e 11) (f 5))
      d '((f 6))
      e nil
      f nil)

(fun node-of mlam (nodes) `(caar ,(car nodes)))
(fun node-cost mlam (nodes) `(cadar ,(car nodes)))

(fun search (node item visited)                         ;; find item in graph denoted by node
     (prog (sub-nodes found)
           (cond [(eq item_node) (return node)]         ;; trivial case
                 [(or (null? (setq sub-nodes (eval node)))
                      (memq node visited))              ;; don't search if already visited
                  (return nil)])
      loop
        (cond [(null? sub-nodes (return nil)]           ;; is not there
              [(setq found                              ;; search a subgraph
                     (search (node-of sub-nodes) item (cons node visited)))
               (return found)])
        (setq sub-nodes (cdr sub-nodes))                ;; try the next arc
        (go loop)))

(search 'a 'c nil)
(search 'a 'm nil)

(fun optimize (node bound)
     (prog [(subnodes (eval mode)) subbound route op-route cost]
           (and (null? subnodes)                        ;; a leaf has cost 0
                (return (list 0 node)))
        loop
           (cond [(null? subnodes)
                  (return (cond [op-route (cons (car op-route)
                                                (cons node (cdr op-route)))]
                                [t (list bound)]))]
                 [(> (setq subbound                     ;; the bound for a subgraph
                           (- bound (setq cost (node-cost subnodes)))) 0)
                     (setq route (optimize (node-of subnodes) subbound))
                     (cond [(< (car route) subbound)    ;; found as better bound?
                            (setq bound (+ (car route) cost)
                                 op-route (cons bound (cdr route)))])])
           (setq subnodes (cdr subnodes))               ;; try next arc
           (go loop)))

(optimize 'a 100)
(optimize 'd 100)
