;; x -> (a b) = a then b
;; x -> a b = a or b
;; <>? = optional
;; <>* = 0 or more
;; <>+ = 1 or more
;; #<> = directive
(defparameter *cpp* '((<preprocessing-file> -> <group>?)
		      (<group> -> 
		       <group-part> 
		       (<group> <group-part>))
		      (<group-part> -> 
		       <if-section> 
		       <control-line> 
		       <text-line> 
		       (#<non-directive))
		      (<if-section> -> (<if-group> <elif-groups>? <else-group>?))
		      (<if-group> -> 
		       (#if <constant-expr> <new-line> <group>?)
		       (#ifdef <identifier> <new-line> <group>?)
		       (#ifndef <identifier> <newline> <group>?))
		      (<elif-groups> -> 
		       <elif-group>
		       (<elif-groups> <elif-group>))
		      (<elif-group> ->
		       (#elif <constant-expr>  <new-line> <group>?))
		      (<else-group> ->
		       (#else <new-line> <group>?))
		      (<endif-line>-> (#endif <new-line>))
		      (<control-line> ->
		       )))
