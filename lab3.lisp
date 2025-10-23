(defun remove-first (elem lst)
  (if (eql elem (car lst))
      (cdr lst)
      (cons (car lst) (remove-first elem (cdr lst)))))

(defun findMinElem (elem lst)
  (cond
    ((null lst) elem)
    ((> elem (car lst)) (findMinElem (car lst) (cdr lst)))
    (t (findMinElem elem (cdr lst)))))

(defun FchoiseSort (lst)
  (if (null (cdr lst))
    lst
    (let* ((min (findMinElem (car lst) (cdr lst)))
          (restList (remove-first min lst)))
      (cons min (FchoiseSort restList)))))

----------------------------------------------------------------------------------------

(defun IchoiseSort (lst)
  (let ((lst-copy (copy-list lst)))    
    (do ((lst-right lst-copy (cdr lst-right)))
        ((null (cdr lst-right)))      
      (let ((min-elem lst-right))
        (do ((lst-for-search (cdr lst-right) (cdr lst-for-search)))
            ((null lst-for-search))
          (when (> (car min-elem) (car lst-for-search))
                 (setf min-elem lst-for-search)))
        (rotatef (car lst-right) (car min-elem))))      
    lst-copy))

----------------------------------------------------------------------------------------

(defun check-choiseSort (name input expected)
  "Execute sort function on `input`, compare result with `expected` and print comparison status"
  (format t "~:[FAILED~;passed~] ~a~%"
          
          ;; --- Виклик для функціональної версії (FchoiseSort) ---
          ;(equal (FchoiseSort input) expected)
          
          ;; --- Виклик для ітеративної версії (IchoiseSort) ---
          (equal (IchoiseSort input) expected)
          
          name))

(defun test-choiseSort ()
  (check-choiseSort "test 1" '(5 3 1 2 4) '(1 2 3 4 5))
  (check-choiseSort "test 2" '(10 9 8 7 6 5) '(5 6 7 8 9 10))
  (check-choiseSort "test 3" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-choiseSort "test 4" '(3) '(3))
  (check-choiseSort "test 5" '() '()))
