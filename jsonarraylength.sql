/*
the json_array_length() function allows you to return the number of elements in a JSON array:

json_array_length(json_array)
In this syntax:

json_array is the JSON array that you want to count the elements.
If json_array is not a JSON array, the json_array_length() function returns 0.

If you want to obtain the number of elements of a JSON array in json_data specified by a path, you can use the following function syntax:

json_array_length(json_data, path)
In this syntax:

json_data is the JSON data from which you want to select the JSON array.
path locates the JSON array within the json_data.
The function returns 0 if the path locates an element that is not a JSON array, or NULL if the path does not locate any element within json_data.

If json_data or path is not well-formed, the json_array_length() function returns an error.

Let’s take some examples of using the json_array_length() function.

1) Getting the number of elements of a JSON array
The following example uses the json_array_length() function to return the number of elements in a JSON array:
*/
SELECT JSON_ARRAY_LENGTH('[1,2,3]');

/*
2) Getting the number of elements of a JSON array specified by a path
The following example uses the json_array_length() function to return the number of elements in a JSON array specified by a path:
*/
SELECT JSON_ARRAY_LENGTH('{"reviews": [1,2,3,4,5]}', '$.reviews');

/*
3) Getting the number of elements of a non-JSON array
The following example uses the json_array_length() function to return the number of elements in a non-JSON array:
*/
SELECT JSON_ARRAY_LENGTH('{"reviews": [1,2,3,4,5]}', '$.reviews[1]') AS result;
/*
It returns zero because the path '$.reviews[1]' returns the first element of the reviews array, which is the number 1.
*/
