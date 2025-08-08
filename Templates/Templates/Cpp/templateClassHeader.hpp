/**
 * @file {{_file_name_}}.h
 * @author {{_author_}}
 * @email {{_email_}}
 * @time {{_lua:os.date("%Y-%m-%d %H:%M")_}}
 * @update {{_lua:os.date("%Y-%m-%d %H:%M")_}}
 * @version 0.0.1
 * @brief {{_file_name_}}
 */

#ifndef __{{_upper_file_}}_HPP__
#define __{{_upper_file_}}_HPP__

/**
 * @class {{_camel_file_}}
 * @brief Template class for demonstrating basic functionality.
 * 
 * @tparam T The type of elements managed by the class.
 */
template <typename T>
class {{_camel_file_}} {
  // Private members
  private:
    T {{_cursor_}}
      
  public:
    // Constructor
    {{_camel_file_}}();
    explicit {{_camel_file_}}(const T&);
  
    // Destructor
    ~{{_camel_file_}}();
  
};

// Implementation of template class methods.

template <typename T>
{{_camel_file_}}<T>::{{_camel_file_}}(){}

template <typename T>
{{_camel_file_}}<T>::{{_camel_file_}}(const T& ) :() {}

template <typename T>
{{_camel_file_}}<T>::~{{_camel_file_}}() = default;

#endif // __{{_upper_file_}}_HPP__
