// all tests must be writen in teh main method
import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_blog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<BlogRepository>()])
import 'get_all_blogs_test.mocks.dart';

void main() {
  late GetAllBlogsUseCase getAllBlogsUseCase;
  late MockBlogRepository mockBlogRepository;

  // Provide a dummy value for 'Either<BaseFailure, List<BlogEntity>>'
  // provideDummy<Either<BaseFailure, List<BlogEntity>>>(right(<BlogEntity>[]));
  provideDummyBuilder<Either<BaseFailure, List<BlogEntity>>>(
    (parent, invocation) => switch (invocation.memberName) {
      #call => const Right(<BlogEntity>[]),
      _ => Left(BaseFailure('')),
    },
  );

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    getAllBlogsUseCase = GetAllBlogsUseCase(mockBlogRepository);
  });

  test(
      'Given the BlogRepositoryUseCase when BlogRepository getAllBlogs is called then it should called once and return List of BlogEntity ',
      () async {
    // arrange
    when(mockBlogRepository.getAllBlogs())
        .thenAnswer((_) async => const Right(<BlogEntity>[]));

    // act - should cover the main functionality of the usecase to be tested
    final result = await getAllBlogsUseCase(NoParams());

    // assert - we verify that the repository was called and that the result is what we expect
    expect(result, equals(const Right(<BlogEntity>[])));
    // we can also verify that the repository was called with a specific argument and that it was called exactly once
    verify(mockBlogRepository.getAllBlogs()).called(1);
    verifyNoMoreInteractions(mockBlogRepository);
  });
}
